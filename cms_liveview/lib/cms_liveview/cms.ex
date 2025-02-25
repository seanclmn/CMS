defmodule CmsLiveview.Cms do
  @moduledoc """
  The Cms context.
  """

  import Ecto.Query, warn: false
  alias CmsLiveview.Repo
  alias CmsLiveview.Cms.Faq
  @doc """
  Returns the list of faqs.

  ## Examples

      iex> list_faqs()
      [%Faq{}, ...]

  """
  def list_faqs() do
    params = %{order: [%{field: :position, order: :asc}]}
    case Flop.validate_and_run(Faq, params, for: Faq, repo: Repo) do
      {:ok, {faqs, meta}} -> faqs
      {:error, _reason} -> []

    end

  end

  @doc """
  Gets a single faq.

  Raises `Ecto.NoResultsError` if the Faq does not exist.

  ## Examples

      iex> get_faq!(123)
      %Faq{}

      iex> get_faq!(456)
      ** (Ecto.NoResultsError)

  """
  def get_faq!(id), do: Repo.get!(Faq, id)

  @doc """
  Creates a faq.

  ## Examples

      iex> create_faq(%{field: value})
      {:ok, %Faq{}}

      iex> create_faq(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_faq(attrs \\ %{}) do
    new_position = Repo.aggregate(Faq, :count) + 1

    %Faq{}
    |> Faq.changeset(Map.put(attrs, "position", new_position))
    |> Repo.insert()
  end

  @doc """
  Updates a faq.

  ## Examples

      iex> update_faq(faq, %{field: new_value})
      {:ok, %Faq{}}

      iex> update_faq(faq, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_faq(%Faq{} = faq, attrs) do
    faq
    |> Faq.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a faq.

  ## Examples

      iex> delete_faq(faq)
      {:ok, %Faq{}}

      iex> delete_faq(faq)
      {:error, %Ecto.Changeset{}}

  """
  def delete_faq(id) do
    faq = get_faq!(id)

    Repo.delete(faq)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking faq changes.

  ## Examples

      iex> change_faq(faq)
      %Ecto.Changeset{data: %Faq{}}

  """
  def change_faq(%Faq{} = faq, attrs \\ %{}) do
    Faq.changeset(faq, attrs)
  end
end
