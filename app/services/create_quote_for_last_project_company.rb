require "open-uri"

class CreateQuoteForLastProjectCompany
  def call
    pc = ProjectCompany.order(created_at: :asc).last
    quote = Quote.create(project_company: pc, price: 115_600)
    file = URI.open(quote_url)
    quote.file.attach(io: file, filename: "quote.pdf", content_type: "pdf")
    quote.save
  end

  private

  def quote_url
    "https://res.cloudinary.com/dpezrfr4o/image/upload/v1686236171/DEVIS_Casa_Gigi-_Mme_POIROUT_ajoi6x.pdf"
  end
end

# CreateQuoteForLastProjectCompany.new.call
