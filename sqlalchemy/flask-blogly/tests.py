import unittest
from app import app
from models import db, User

class UserTestCase(unittest.TestCase):
    def setUp(self):
        """Create test client, add sample data."""
        self.client = app.test_client()
        app.config['TESTING'] = True

        db.create_all()

    def tearDown(self):
        """Clean up any fouled transaction."""
        db.session.remove()
        db.drop_all()

    def test_home_page_redirect(self):
        """Test homepage redirect to /users."""
        response = self.client.get('/')
        self.assertEqual(response.status_code, 302)

    def test_list_users(self):
        """Test that /users page displays users."""
        response = self.client.get('/users')
        self.assertIn('All Users', response.data)

    def test_add_user(self):
        """Test adding a new user."""
        self.client.post('/users/new', data={'first_name': 'Test', 'last_name': 'User', 'image_url': ''})
        user = User.query.filter_by(first_name='Test').first()
        self.assertIsNotNone(user)

    def test_user_detail(self):
        """Test user detail page."""
        user = User(first_name="Test", last_name="User")
        db.session.add(user)
        db.session.commit()
        response = self.client.get(f'/users/{user.id}')
        self.assertIn('Test User', response.data)

if __name__ == '__main__':
    unittest.main()
