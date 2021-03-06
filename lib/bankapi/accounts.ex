defmodule Bank.Accounts do
  @moduledoc """
  The Accounts context.
  """

  @initial_balance 1000

  import Ecto.Query, warn: false
  alias Bank.Repo

  alias Bank.Accounts.Account

  alias Bank.Clients.Client

  @doc """
  Returns the list of account.

  ## Examples

      iex> list_account()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id) do
    Account
    |> Repo.get!(id)
  end

  @doc """
  Gets accounts to client.

  """
  def get_account_by_client!(client_id) do
    Account
    |> where(client_id: ^client_id)
    |> Repo.all()
  end

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}, user_id) do
    Client
    |> Repo.get(user_id)
    |> Ecto.build_assoc(:accounts)
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end

  def generate_account_data(_client) do
    {:ok,
     %{
       balance: @initial_balance,
       identify: generate_identify(),
       type: "A"
     }}
  end

  defp generate_identify do
    max_alf = String.to_integer("ZZ", 36)
    min_alf = String.to_integer("AA", 36)

    alf_num =
      min_alf
      |> rand_in_interval(max_alf)
      |> Integer.to_string(36)

    min_num = 1000
    max_num = 9999

    num = rand_in_interval(min_num, max_num)

    "#{num}-#{alf_num}"
  end

  defp rand_in_interval(min, max) do
    max
    |> Kernel.-(min)
    |> :rand.uniform()
    |> Kernel.+(min)
  end
end
