class AddTokensToAgent < ActiveRecord::Migration[5.2]
  def change
    add_column :agents, :access_token, :string
    add_column :agents, :refresh_token, :string
    add_column :agents, :expires_at, :datetime
  end
end
