defmodule CmsLiveview.CmsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CmsLiveview.Cms` context.
  """

  @doc """
  Generate a faq.
  """
  def faq_fixture(attrs \\ %{}) do
    {:ok, faq} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        question: "some question"
      })
      |> CmsLiveview.Cms.create_faq()

    faq
  end
end
