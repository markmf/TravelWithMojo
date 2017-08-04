class CreatePayoffs < ActiveRecord::Migration[5.1]
  def change
    create_table :payoffs do |t|
      t.references :user, foreign_key: true
  
      t.string :custom_stripe_id
      t.string :country
      t.string :type
      t.integer :dob_day
      t.integer :dob_month
      t.integer :dob_year
      t.string :gender
      t.string :phone_no

      t.string :first_name_kana
      t.string :first_name_kanji
      t.string :last_name_kana
      t.string :last_name_kanji
      t.string :business_name_kana
      t.string :business_name_kanji
  
      t.string :address_line1_kana
      t.string :address_line1_kanji
      t.string :address_line2_kana
      t.string :address_line2_kanji
      t.string :state_kana
      t.string :state_kanji
      t.string :city_kana
      t.string :city_kanji
      t.string :town_kana
      t.string :town_kanji
     
      t.string :postal_code

      t.string :bank_name
      t.string :branch_name
      t.string :account_name_kana
      t.string :account_name_english
      t.string :account_no
      t.string :swift
      t.string :bank_code
      t.string :branch_code
      t.integer :account_type

      t.timestamps
    end
  end
end