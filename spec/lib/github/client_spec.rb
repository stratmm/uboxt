require 'rails_helper'
require 'github/client'

describe GitHub::Client do
  let(:user_name) { 'stratmm' }
  subject { described_class.new(user_name) }

  # First failing test when starting development of a new module,
  # usually removed once you have the this up and running
  it { is_expected.to be }

  context "#user" do
    it 'returns the username' do
      expect(subject.user).to include(login: 'stratmm')
    end

    it 'retuns the full name' do
      expect(subject.user).to include(name: 'Mark Stratmann')
    end
  end

  context "#repositories" do
    it "returns all the user repos" do
      expect(subject.repositories.any? { |repo| repo[:name] == 'uboxt' }).to eql true
    end
  end

  context "#language_count" do
    it "returns the favorite language" do
      expect(subject.language_count.keys).to include "Ruby"
    end
  end
end
