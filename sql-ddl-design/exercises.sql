-- Medical Center

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name TEXT(50) NOT NULL,
    specialty TEXT(50),
    hire_date DATE
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name TEXT(50) NOT NULL,
    birth_date DATE,
    gender CHAR(1)
);

CREATE TABLE Visits (
    visit_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    visit_date DATE,
    notes TEXT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE Diseases (
    disease_id INT PRIMARY KEY,
    name TEXT(50) NOT NULL,
    description TEXT
);

CREATE TABLE Diagnoses (
    diagnosis_id INT PRIMARY KEY,
    visit_id INT,
    disease_id INT,
    comments TEXT,
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id),
    FOREIGN KEY (disease_id) REFERENCES Diseases(disease_id)
);

-- Craigslist

CREATE TABLE Regions (
    region_id INT PRIMARY KEY,
    name TEXT(50) NOT NULL
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username TEXT(30) NOT NULL,
    email TEXT(50) NOT NULL,
    preferred_region_id INT,
    FOREIGN KEY (preferred_region_id) REFERENCES Regions(region_id)
);

CREATE TABLE Posts (
    post_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    title TEXT(50) NOT NULL,
    description TEXT,
    price INT,
    region_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name TEXT(50) NOT NULL
);

CREATE TABLE Post_Categories (
    post_id INT,
    category_id INT,
    PRIMARY KEY (post_id, category_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Soccer League

CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    name TEXT(50) NOT NULL,
    city TEXT(50)
);

CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    name TEXT(50) NOT NULL,
    team_id INT,
    position TEXT(10),
    goals INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

CREATE TABLE Referees (
    referee_id INT PRIMARY KEY,
    name TEXT(50) NOT NULL,
);

CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    home_team_id INT,
    away_team_id INT,
    match_date DATE,
    season_id INT,
    FOREIGN KEY (home_team_id) REFERENCES Teams (team_id),
    FOREIGN KEY (away_team_id) REFERENCES Teams (team_id),
    FOREIGN KEY (referee_id) REFERENCES Referees (referee_id)
    FOREIGN KEY (season_id) REFERENCES Seasons (season_id)
);

CREATE TABLE Goals (
    goal_id INT PRIMARY KEY,
    player_id INT,
    match_id INT,
    FOREIGN KEY (player_id) REFERENCES Players (player_id),
    FOREIGN KEY (match_id) REFERENCES Matches (match_id)
);

CREATE TABLE Seasons (
    season_id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE
);