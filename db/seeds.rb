# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#


user = User.create(name: "Naveen", email: "naveendurai19@gmail.com", password: "password")
# user.update_attributes()

# Movies
Medium.create(name: "Iron Man", plot: "When an industrialist is captured, he constructs a high-tech armoured suit to escape. Once he manages to escape, he decides to use his suit to fight against evil forces and save the world", media_type: "movie")
# Seasons
season = Medium.create(name: "F.R.I.E.N.D.S Season 1", plot: "Follow the lives of six reckless adults living in Manhattan, as they indulge in adventures which make their lives both troublesome and happening.", media_type: "season")
# Episodes
Submedium.create(name: "S01E01 Pilot", parent_medium_id: season.id, plot: "Rachel moves in with Monica, finding newfound independence after leaving her fiancé at the altar. Chandler and Joey console Ross after his divorce from Carol, his lesbian wife. Monica falls for a colleague and is crushed to learn their moment of passion was only a one night stand.", sub_id: 1)

Submedium.create(name: "S01E02 The One with the Sonogram at the End", parent_medium_id: season.id, plot: "Carol, Ross' lesbian ex-wife, tells him at work that she is pregnant with his child and, when he attends the sonogram, is stunned to learn that she wants to give the baby her and her lesbian lover's last names. Monica nearly has a breakdown from stressing when her and Ross' parents come for dinner. Ross and Rachel console each other, as she has to return her engagement ring to Barry and finds out that he and her maid of honor Mindy, went on her honeymoon.", sub_id: 2)

