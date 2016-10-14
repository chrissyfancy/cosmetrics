class AddIndexToVotes < ActiveRecord::Migration[5.0]
  def change
    add_index(:votes, [:review_id, :user_id], name: "index_votes_on_review_id_and_user_id", unique: true)
  end
end
