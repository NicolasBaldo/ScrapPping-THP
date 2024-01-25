require 'nokogiri'
require 'open-uri'

# Définir la méthode get_townhall_urls en premier
def get_townhall_urls
  base_url = 'https://www.annuaire-des-mairies.com/val-d-oise.html'
  page = Nokogiri::HTML(URI.open(base_url))
  townhall_urls = []
   # variable utilisée pour stocker les données extraites des urls
  page.css('a.lientxt').each do |link|
    townhall_url = "https://www.annuaire-des-mairies.com#{link['href'][1..-1]}"
    townhall_urls << townhall_url
  end
# get_townhall_urls récupère les URLs de chaque mairie du Val d'Oise à partir de la page principale de l'annuaire des mairies.

  return townhall_urls
end

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))
  email = page.css('td:contains("@")').text.strip
  return email
end
# get_townhall_email prend une URL de mairie en entrée, accède à la page de cette mairie, et extrait l'adresse e-mail de la mairie.


def get_townhall_emails
  townhall_urls = get_townhall_urls
  townhall_emails = []

  townhall_urls.each do |url|
    email = get_townhall_email(url)
    townhall_name = url.split('/')[-1].gsub(/-|\.html/, '').capitalize
    # utilise la méthode gsub (Global Substitution) pour supprimer tous les tirets (-) et les  .html dans le segment du nom de la mairie.
    townhall_emails << { townhall_name => email }
  end

  return townhall_emails
end
# get_townhall_emails utilise les deux méthodes précédentes 
#pour obtenir les e-mails de toutes les mairies du Val d'Oise et les stocker dans un tableau de hashs.

townhall_emails = get_townhall_emails

townhall_emails.each do |townhall|
  townhall.each do |name, email|
    puts "{ \"#{name}\" => \"#{email}\" },"
    # Affichage de l'array de hashs avec une esthétique similaire à  crypto-scrap
  end
end
