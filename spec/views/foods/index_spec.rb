require 'rails_helper'

RSpec.describe 'foods/index', type: :feature do
  describe 'after log in' do
    before(:each) do
      @user1 = User.create(name: 'Jonas', email: 'jonas@gmail.com', password: 'jonas1234', confirmed_at: Time.now)
      @food1 = Food.create(name: 'Burger', measurement_unit: 'grams', price: 10, quantity: 2, user_id: @user1.id)
      @food2 = Food.create(name: 'Pizza', measurement_unit: 'slices', price: 20, quantity: 5, user_id: @user1.id)

      visit 'users/sign_in'
      fill_in 'Email', with: 'jonas@gmail.com'
      fill_in 'Password', with: 'jonas1234'
      click_on 'Log in'
    end

    it 'displays Foods list in navbar' do
      visit 'foods'
      expect(page).to have_content 'Food'
    end

    it 'displays a list of the foods' do
      visit 'foods'
      expect(page).to have_content 'Burger'
      expect(page).to have_content 'Pizza'
    end

    it 'has a button to add new food' do
      visit 'foods'
      expect(page).to have_content 'Add Food'
    end

    it 'should take you to add food form when clicking on the button' do
      visit 'foods'
      click_link('Add Food')
      expect(current_path).to eql new_food_path
    end
  end
end
