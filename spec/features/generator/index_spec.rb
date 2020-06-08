require 'rails_helper'

RSpec.describe 'When a user visits the root path', type: :feature do
    describe 'as a visitor' do
        before(:each) do
            visit '/'
        end

        it 'they see a text field to input a hex value' do
            expect(page).to have_field('Hex Value')
        end

        it 'they see toggle buttons for several palette types' do
            expect(page).to have_checked_field 'Complement'
            expect(page).to have_unchecked_field 'Triad'
            expect(page).to have_field 'Tetrad'
            expect(page).to have_field 'Split Complement'
            expect(page).to have_field 'Analogous'
            expect(page).to have_field 'Monochromatic'
        end

        it 'they see a button to generate a palette' do
            expect(page).to have_button 'Generate'
        end

        describe 'and inputs a valid hex value, chooses a non-default palette type, and submits it' do
            before(:each) do
                fill_in 'Hex Value', with: '#000080'
                choose 'Triad'
                click_on 'Generate'
            end

            it 'they see colors for that non-default palette type' do
                within '.palette' do
                    expect(page).to have_content 'navy'
                    expect(page).to have_content 'maroon'
                    expect(page).to have_content 'green'
                end
            end
        end

        describe 'and inputs a valid hex value and select submit with default palette option' do
            before(:each) do
                fill_in 'Hex Value', with: '#000080'
                click_on 'Generate'
            end

            it 'they remain on that route' do
                expect(current_path).to eq('/')
            end

            it 'they see each color in the generated palette and its identifying information' do
                within '.palette' do
                    within '.color:first-of-type' do
                        expect(page).to have_content 'HSV'
                        expect(page).to have_content 'hsv(240, 100%, 50%'
                        expect(page).to have_content 'RGB'
                        expect(page).to have_content 'rgb(0, 0, 128)'
                        expect(page).to have_content 'Hex'
                        expect(page).to have_content '#000080'
                        expect(page).to have_content 'Hex8'
                        expect(page).to have_content '#ff000080'
                        expect(page).to have_content 'CSS Name'
                        expect(page).to have_content 'navy'
                    end

                    within '.color:nth-of-type(2)' do
                        expect(page).to have_content 'HSV'
                        expect(page).to have_content "hsv(60, 100%, 50%)"
                        expect(page).to have_content 'RGB'
                        expect(page).to have_content 'rgb(128, 128, 0)'
                        expect(page).to have_content 'Hex'
                        expect(page).to have_content '#808000'
                        expect(page).to have_content 'Hex8'
                        expect(page).to have_content '#ff808000'
                        expect(page).to have_content 'CSS Name'
                        expect(page).to have_content 'olive'                        
                    end
                end
            end
        end
    end
end