class CreateGithubStars < ActiveRecord::Migration[5.0]
  def change
    create_table :github_stars do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :repo_id
      t.string :name
      t.string :full_name
      t.string :html_url
      t.string :description
      t.string :homepage

      t.timestamps
    end
  end
end
