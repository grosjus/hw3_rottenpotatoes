# Add a declarative step here for populating the DB with movies.
#on peut utiliser :
#debugger

Given /the following movies exist/ do |movies_table|
  Movie.delete_all
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title=>movie[:title],:release_date=>movie[:release_date],:rating=>movie[:rating])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  debugger
  assert page.body.scan(/#{e1}(.|\n)*#{e2}/).length!=0
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |r|
    uncheck==:un.to_s ? uncheck("ratings_#{r}") : check("ratings_#{r}")
  end
end

When /I should see all of the movies/ do
  rows=page.body.split("</tr>").length-2
  assert rows==10
  #j'ai pas compris le coup du should.
end


# NE MARCHE PAS : le rowcount n'a jamais faux, le aladdin devrait pas être là. et le should not see