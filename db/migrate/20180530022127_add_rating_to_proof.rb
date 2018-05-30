class AddRatingToProof < ActiveRecord::Migration[5.1]
  def change
    add_column :proofs, :rating, :decimal, { precision: 3, scale: 2 }

    reversible do |mig|
      mig.up do
        # add a CHECK constraint
        execute <<-SQL
           ALTER TABLE proofs
             ADD CONSTRAINT ensure_rating_between_0_and_1
               CHECK (rating >=0 and rating <= 1);
         SQL
      end
      mig.down do
        execute <<-SQL
           ALTER TABLE proofs
             DROP CONSTRAINT ensure_rating_between_0_and_1;
         SQL
      end
    end
  end

end
