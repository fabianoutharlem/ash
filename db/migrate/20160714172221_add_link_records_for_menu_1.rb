class AddLinkRecordsForMenu1 < ActiveRecord::Migration
  def change
    Link.create(title: 'Contact', url: '/contact')
    Link.create(title: 'Financieringen', url: '/financieringen')
    Link.create(title: 'Particuliere financieringen', url: '/particuliere_financieringen')
    Link.create(title: 'Zakelijke financieringen', url: '/zakelijke_financieringen')
    Link.create(title: '50/50 deals', url: '/50_50_deals')
    Link.create(title: 'Disclaimer', url: '/disclaimer')
    Link.create(title: 'Home', url: '/')
    Link.create(title: 'Voorraad', url: '/autos')
    Link.create(title: 'Recensies', url: '/reviews')
    Link.create(title: 'Auto kredietplan', url: 'http://autokredietplan.nl')
    Link.create(title: 'Auto totaal haarlem', url: 'http://autototaalhaarlem.nl')
    Link.create(title: 'Sitemap', url: '/site_map')
    Link.create(title: 'Vacatures', url: '/vacatures')
    Link.create(title: 'Link partners', url: '/link_partners')
  end
end
