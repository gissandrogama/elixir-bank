# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bank.Repo.insert!(%Bank.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Bank.Users

# Adicionar user admin a base.
Users.create_user(%{
  username: "admin",
  password: "adminAdmin",
  password_confirmation: "adminAdmin"
})
