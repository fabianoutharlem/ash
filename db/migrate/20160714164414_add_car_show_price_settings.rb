class AddCarShowPriceSettings < ActiveRecord::Migration
  def change
    Setting.create(name: 'Auto staffel contant', setting: 'car_detail_staffel_cash', type: 'Settings::TextField', value: '10931')
    Setting.create(name: 'Auto staffel aanbetaling', setting: 'car_detail_staffel_deposit', type: 'Settings::TextField', value: '2597.75')
    Setting.create(name: 'Auto staffel kredietbedrag', setting: 'car_detail_staffel_credit_amount', type: 'Settings::TextField', value: '2597.75')
    Setting.create(name: 'Auto staffel slottermijn', setting: 'car_detail_staffel_closing_payment', type: 'Settings::TextField', value: '5195.5')
    Setting.create(name: 'Auto staffel termijbedrag', setting: 'car_detail_staffel_term_amount', type: 'Settings::TextField', value: '117.02')
    Setting.create(name: 'Auto staffel totaal voor de consument', setting: 'car_detail_staffel_consumer_total', type: 'Settings::TextField', value: '9408.22')
    Setting.create(name: 'Auto staffel jaarlijkse kosten', setting: 'car_detail_staffel_yearly', type: 'Settings::TextField', value: '9408.22')
    Setting.create(name: 'Auto staffel debet rentevoet', setting: 'car_detail_staffel_interest_foot', type: 'Settings::TextField', value: '8.49')
    Setting.create(name: 'Auto staffel looptijd', setting: 'car_detail_staffel_duration', type: 'Settings::TextField', value: '36')
  end
end
