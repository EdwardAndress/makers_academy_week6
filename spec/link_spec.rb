require 'spec_helper'

describe Link do

		context "Links can" do

			it 'be stored in the db' do 
				expect(Link.count).to eq 0
				Link.create(title: "my photos",
							url: "http://andressedward.tumblr.com")
				expect(Link.count).to eq 1
			end

			it 'be recalled from the db' do
				Link.create(title: "my photos",
							url: "http://andressedward.tumblr.com")
				expect(Link.count).to eq 1

				link = Link.first
				expect(link.url).to eq 'http://andressedward.tumblr.com'
				expect(link.title).to eq 'my photos'
			end

		end

end