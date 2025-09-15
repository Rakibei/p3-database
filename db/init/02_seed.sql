-- Example seed data — remove or change as you like
INSERT INTO public.users (email, display_name) VALUES
	('alice@example.com', 'Alice'),
	('bob@example.com', 'Bob')
ON CONFLICT DO NOTHING;