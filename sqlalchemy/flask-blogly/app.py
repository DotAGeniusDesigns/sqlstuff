from flask import Flask, request, redirect, render_template, url_for
from models import db, connect_db, User, Post

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///blogly'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = "secret"
app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False
debug = DebugToolbarExtension(app)

connect_db(app)
db.create_all()

@app.route('/')
def root():
    """Homepage redirects to list of users."""
    return redirect("/users")

@app.route('/users')
def list_users():
    """Show all users."""
    users = User.query.all()
    return render_template("users.html", users=users)

@app.route('/users/new')
def new_user():
    """Show an add form for users."""
    return render_template('new_user.html')

@app.route('/users/new', methods=['POST'])
def add_user():
    """Process the add form, adding a new user and going back to /users."""
    new_user = User(
        first_name=request.form['first_name'],
        last_name=request.form['last_name'],
        image_url=request.form['image_url'] or None
    )
    db.session.add(new_user)
    db.session.commit()
    return redirect('/users')

@app.route('/users/<int:user_id>')
def show_user(user_id):
    """Show information about the given user."""
    user = User.query.get_or_404(user_id)
    return render_template('user_detail.html', user=user)

@app.route('/users/<int:user_id>/edit')
def edit_user(user_id):
    """Show the edit page for a user."""
    user = User.query.get_or_404(user_id)
    return render_template('edit_user.html', user=user)

@app.route('/users/<int:user_id>/edit', methods=['POST'])
def update_user(user_id):
    """Process the edit form, returning the user to the /users page."""
    user = User.query.get_or_404(user_id)
    user.first_name = request.form['first_name']
    user.last_name = request.form['last_name']
    user.image_url = request.form['image_url'] or user.image_url
    db.session.commit()
    return redirect('/users')

@app.route('/users/<int:user_id>/delete', methods=['POST'])
def delete_user(user_id):
    """Delete the user."""
    user = User.query.get(user_id)
    if user:
        db.session.delete(user)
        db.session.commit()
    return redirect('/users')

@app.route('/users/<int:user_id>/posts/new')
def new_post_form(user_id):
    """Show form to add a post for that user."""
    user = User.query.get_or_404(user_id)
    return render_template('new_post.html', user=user)

@app.route('/users/<int:user_id>/posts/new', methods=['GET', 'POST'])
def add_post(user_id):
    """Add a new post for a user."""
    user = User.query.get_or_404(user_id)
    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        tag_ids = [int(tid) for tid in request.form.getlist('tags')]
        tags = Tag.query.filter(Tag.id.in_(tag_ids)).all()
        new_post = Post(title=title, content=content, user=user, tags=tags)
        db.session.add(new_post)
        db.session.commit()
        return redirect(url_for('show_user', user_id=user.id))
    tags = Tag.query.all()
    return render_template('new_post.html', user=user, tags=tags)


@app.route('/posts/<int:post_id>')
def show_post(post_id):
    """Show a post."""
    post = Post.query.get_or_404(post_id)
    return render_template('post_detail.html', post=post)

@app.route('/posts/<int:post_id>/edit')
def edit_post_form(post_id):
    """Show form to edit a post."""
    post = Post.query.get_or_404(post_id)
    return render_template('edit_post.html', post=post)

@app.route('/posts/<int:post_id>/edit', methods=['POST'])
def edit_post(post_id):
    """Handle editing of a post."""
    post = Post.query.get_or_404(post_id)
    post.title = request.form['title']
    post.content = request.form['content']
    db.session.commit()
    return redirect(url_for('show_post', post_id=post.id))

@app.route('/posts/<int:post_id>/delete', methods=['POST'])
def delete_post(post_id):
    """Delete the post."""
    post = Post.query.get_or_404(post_id)
    db.session.delete(post)
    db.session.commit()
    return redirect(url_for('list_users'))

@app.route('/tags')
def list_tags():
    """Display list of tags."""
    tags = Tag.query.all()
    return render_template('tags_list.html', tags=tags)

@app.route('/tags/new', methods=['GET', 'POST'])
def new_tag():
    """Create a new tag."""
    if request.method == 'POST':
        name = request.form['name']
        new_tag = Tag(name=name)
        db.session.add(new_tag)
        db.session.commit()
        return redirect(url_for('list_tags'))
    return render_template('new_tag.html')

@app.route('/tags/<int:tag_id>')
def show_tag(tag_id):
    """Show detail about a tag."""
    tag = Tag.query.get_or_404(tag_id)
    return render_template('tag_detail.html', tag=tag)

@app.route('/tags/<int:tag_id>/edit', methods=['GET', 'POST'])
def edit_tag(tag_id):
    """Edit a tag."""
    tag = Tag.query.get_or_404(tag_id)
    if request.method == 'POST':
        tag.name = request.form['name']
        db.session.commit()
        return redirect(url_for('list_tags'))
    return render_template('edit_tag.html', tag=tag)

@app.route('/tags/<int:tag_id>/delete', methods=['POST'])
def delete_tag(tag_id):
    """Delete a tag."""
    tag = Tag.query.get(tag_id)
    if tag:
        db.session.delete(tag)
        db.session.commit()
    return redirect(url_for('list_tags'))
