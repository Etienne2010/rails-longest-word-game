require "application_system_test_case"

  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit initial_url
    click_on "Start game"
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Random word is not valid" do
    visit initial_url
    click_on "Start game"
    visit new_url
    fill_in "input", with: "Absurdity"
    click_on "Suggest your word"
    assert_text "Word cannot be built from grid"
  end

  test "One letter word is not valid" do
    visit initial_url
    click_on "Start game"
    visit new_url
    fill_in "input", with: "p"
    click_on "Suggest your word"
    assert_text "word is not english"
  end


end
