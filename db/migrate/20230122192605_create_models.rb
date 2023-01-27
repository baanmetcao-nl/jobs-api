# frozen_string_literal: true

class CreateModels < ActiveRecord::Migration[7.0]
  def up
    enable_extension :citext

    create_table :users do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false
      t.integer :status, null: false, index: true, default: 0
      t.timestamp :activated_at, null: true

      t.check_constraint 'char_length(first_name) >= 2'
      t.check_constraint 'char_length(first_name) <= 50'
      t.check_constraint 'char_length(last_name) >= 2'
      t.check_constraint 'char_length(last_name) <= 50'

      t.timestamps
    end

    create_table :email_addresses, &:timestamps

    add_column :email_addresses, :email, :citext, null: false, index: { unique: true }

    create_table :user_email_addresses do |t|
      t.belongs_to :user, null: false
      t.belongs_to :email_address, null: false
      t.integer :use, null: false, default: 0
    end

    add_index :user_email_addresses, %i[user_id email_address_id], unique: true
    add_index :user_email_addresses, %i[user_id use], unique: true

    add_foreign_key :user_email_addresses, :users
    add_foreign_key :user_email_addresses, :email_addresses

    create_table :companies do |t|
      t.text :name, null: false, index: true
      t.text :location, null: false
      t.text :website_url, null: false

      t.check_constraint 'char_length(name) >= 2'
      t.check_constraint 'char_length(name) <= 50'
      t.check_constraint 'char_length(location) >= 5'
      t.check_constraint 'char_length(location) <= 50'

      t.timestamps
    end

    create_table :employers do |t|
      t.belongs_to :company, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end

    add_foreign_key :employers, :companies
    add_foreign_key :employers, :users

    create_table :jobs do |t|
      t.belongs_to :employer, null: false
      t.text :position, null: false, index: true
      t.text :description, null: false, index: true
      t.integer :experience, null: false, index: true, default: 0
      t.integer :status, null: false, index: true, default: 0
      t.timestamp :expires_at, null: false, index: true
      t.timestamp :published_at, index: true

      t.check_constraint 'experience >= 0'
      t.check_constraint 'experience <= 3'
      t.check_constraint 'char_length(position) >= 3'
      t.check_constraint 'char_length(position) <= 50'
      t.check_constraint 'char_length(description) >= 100'
      t.check_constraint 'char_length(description) <= 5000'

      t.timestamps
    end

    add_foreign_key :jobs, :employers

    create_table :benefits do |t|
      t.belongs_to :job, null: false
      t.decimal :min_salary, null: false, precision: 8, scale: 2
      t.decimal :max_salary, null: false, precision: 8, scale: 2
      t.integer :vacation_days, null: false
      t.boolean :pension, null: false

      t.check_constraint 'vacation_days >= 15'
      t.check_constraint 'vacation_days <= 200'

      t.check_constraint 'max_salary >= min_salary'
      t.check_constraint 'min_salary >= 10000'
      t.check_constraint 'min_salary <= 9999999'
      t.check_constraint 'max_salary >= 10000'
      t.check_constraint 'max_salary <= 9999999'

      t.timestamps
    end

    add_foreign_key :benefits, :jobs
  end

  def down
    drop_extension :citext

    drop_table :employers
    drop_table :email_addresses
    drop_table :user_email_addresses
    drop_table :users
    drop_table :benefits
    drop_table :jobs
    drop_table :companies
  end
end
