require 'nokogiri'
require 'open-uri'

url = 'https://coinmarketcap.com/all/views/all/'

begin
  crypto_data = []
   # variable utilisée pour stocker les données extraites des cryptomonnaies.
  (1..10).each do |page_number|  
    # Suppose que chaque page contient 20 cryptomonnaies
    page_url = "#{url}?page=#{page_number}"
    page = Nokogiri::HTML(URI.open(page_url))

    break if page.css('tr.cmc-table-row').empty?  
    # Arrête si la page ne contient pas de cryptomonnaies

    # Extraction des données de la page
    page.css('tr.cmc-table-row').each do |crypto_row|
      symbol = crypto_row.css('.cmc-table__column-name--symbol').text.strip
      name = crypto_row.css('.cmc-table__column-name--name').text.strip
      market_cap = crypto_row.css('.cmc-table__cell--sort-by__market-cap .sc-7bc56c81-0').text.strip
      price = crypto_row.css('.cmc-table__cell--sort-by__price span').text.strip
      # Calcul effectué à partir de le div d'une ligne de crypto choppée sur le site en question
      # la boucle opère sur chaque ligne de la page actuelle, extrayant les informations telles que le symbole, le nom, la capitalisation boursière et le prix. 
     
      if symbol != '' && name != '' && market_cap != '' && price != ''
          # La condition Supprime les caractères non numériques du prix
        crypto_data << { symbol => price.gsub(/[^0-9.]/, '').to_f }  
        # La regex pour supprime tous les caractères qui ne sont pas des chiffres ou des points du prix. 
       
      end
    end
  end

  # Affichage de l'array de hashs avec une estétique imposée 
  crypto_data.each do |crypto|
    crypto.each do |symbol, value|
      puts "{ \"#{symbol}\" => #{value} },"
       # Affichage de l'array de hashs avec une estétique imposée 
    end
  end

rescue OpenURI::HTTPError => e
  puts "Erreur HTTP lors de l'ouverture de l'URL : #{e.message}"
rescue StandardError => e
  puts "Une erreur inattendue s'est produite : #{e.message}"
end
