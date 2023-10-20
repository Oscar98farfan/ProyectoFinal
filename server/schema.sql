CREATE DATABASE todo_app;

USE todo_app;

CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255),
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255)
);

CREATE TABLE todos (
	id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255),
	completed BOOLEAN DEFAULT false,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE 
);

CREATE TABLE shared_todos (
	id INT AUTO_INCREMENT PRIMARY KEY,
	todo_id INT,
	user_id INT,
	shared_with_id INT,
	FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY (shared_with_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO shared_todos (todo_id, user_id)
VALUES (1, 2, 2);

INSERT INTO users (name, email, password) VALUES ('Oscar', 'oscar@gamil.com', 'asdf123');
INSERT INTO users (name, email, password) VALUES ('Daniel', 'daniel@gmail.com', 'asdf123');
INSERT INTO users (name, email, password) VALUES ('Tatiana', 'tatiana@gmail.com', 'asdf123');

INSERT INTO todos (title, user_id) 
VALUES 
("Terminar proyecto DevF 👨‍💻👨‍💻", 1),
("Hacer presentacion de inlges 🖼️🖼️", 1),
("Hacer el mercado de la semana 🛒🛒", 1),
("Leer 30 minutos al dia 📚📖", 1),
("Comprar ropa 🛍️🛍️", 1),
("Hacer una hora de ejercicio 🏋️🏋️", 1),
("Practicar yoga 🧘‍♂️🧘‍♂️", 1);

INSERT INTO shared_todos (todo_id, user_id, shared_with_id) VALUES (1, 1, 2);

DELETE FROM todos WHERE id = 1;

DELETE FROM todos;

DROP DATABASE todo_app;

SELECT todos.*
FROM todos 
JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE shared_todos.user_id = [user_id] ;

SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE todos.user_id = [user_id] OR shared_todos.shared_with_id = [user_id];
