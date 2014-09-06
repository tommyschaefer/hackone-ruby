require 'spec_helper'

describe HackOne do
  let(:app) { described_class.new('spec/test.json') }

  describe '#initialize' do
    let(:username) { 'ehzhang' }

    it 'retrives the correct file address at creates the commonApp object' do
      expect(app.username).to eql username
    end

    it 'retrives a correct file address and correct url and creates the commonApp object' do
      app_web = described_class.new('http://pastebin.com/raw.php?i=FSBr9BCK')
      expect(app_web.username).to eql username
    end
  end

  describe '#fetch_item' do
    it "gives an error message if the method doesn't exist" do
      error_msg = 'Error: Cannot find this field.'
      result = app.fetch('bio', 'totally_flase_field')
      expect(result).to eql error_msg
    end

    it 'returns the correct attribute for an existing method' do
      result = app.fetch('bio', 'email')
      expect(result).to eql 'ehzhang@mit.edu'
    end

    # fetch will only work on a vaild object, so We do not need to check for blanks
  end

  describe '#check_accessors' do
    subject { app }

    its(:username) { is_expected.to eq 'ehzhang' }
    its(:email) { is_expected.to eq 'ehzhang@mit.edu' }
    its(:lastUpdated) { is_expected.to eq 'Sat, 26 Jul 2014 01:55:43 GMT' }
  end

  describe '#check_bio' do
    it 'returns the correct email when asked' do
      expect(app.bio('email')).to eql 'ehzhang@mit.edu'
    end

    it 'returns the correct phone when asked' do
      expect(app.bio('phone')).to eql '908-798-1998'
    end
  end

  describe 'the object' do
    subject { app }

    its(:education) do
      is_expected.to eq [{ institution: 'MIT',
                           areas: ['Computer Science'],
                           studyType: "Bachelor's",
                           start: '2012',
                           end: '2016' }]
    end

    its(:work) do
      is_expected.to eq [{ company: 'Groupon',
                           position: 'Software Engineering Intern',
                           start: 'June 2014',
                           end: 'Aug 2014',
                           description: 'Worked on user interfaces for financial engineering, etc.' }]
    end

    its(:hackathons) do
      is_expected.to eq [{ name: 'Greylock Hackfest',
                           season: 'Summer',
                           year: '2014',
                           awards: ['Finalist'],
                           project: { name: 'sense.js',
                                      link: 'http://sense-js.jit.su',
                                      image: '<link to your image>',
                                      description: 'An HTML5 Interaction Library',
                                      technologies: %w(Javascript HTML5 Node.js Socket.IO) }
                         }]
    end

    its(:projects) do
      is_expected.to eq [{ name: 'commonhack',
                           description: 'A common hackathon application/hacker showcase',
                           link: 'http://commonhack.org',
                           image: '<link to your image>' }]
    end

    its(:skills) do
      is_expected.to eq %w(Javascript HTML CSS Python Node)
    end
  end
end
