class FixTournamentLeaguesColumnTypeWithSql < ActiveRecord::Migration
  def change
    execute "ALTER TABLE tournaments ALTER COLUMN leagues DROP DEFAULT;"
    execute "ALTER TABLE tournaments ALTER COLUMN leagues TYPE CHARACTER VARYING(255)[] USING ARRAY[leagues]::CHARACTER(255)[];"
    execute "ALTER TABLE tournaments ALTER COLUMN leagues SET DEFAULT '{}';"
  end
end
