require_relative 'spec_helper'
require_relative '../lib/Mayor-scrap'  

RSpec.describe 'Townhall Scraper' do
  describe '#get_townhall_urls' do
    it 'returns an array of townhall URLs' do
      urls = get_townhall_urls
      expect(urls).to be_an(Array)
      expect(urls).not_to be_empty
    end
  end

  describe '#get_townhall_email' do
    let(:sample_url) { 'https://www.annuaire-des-mairies.com/95/avernes.html' }

    it 'returns an email for a given townhall URL' do
      email = get_townhall_email(sample_url)
      expect(email).to be_a(String)
      expect(email).not_to be_empty
      expect(email).to match(/@/)  
    end
  end

  describe '#get_townhall_emails' do
    it 'returns an array of hashes with townhall names and emails' do
      emails = get_townhall_emails
      expect(emails).to be_an(Array)
      expect(emails).not_to be_empty
      expect(emails[0]).to include("Ableiges" => "mairie.ableiges95@wanadoo.fr")
       # Spécification de ce mail car c'est le premier de la liste 

    end
  end
end
