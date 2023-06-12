require "open-uri"

class CreateQuoteForLastProjectCompany
  def initialize(project: nil)
    @project_company = if project.present?
                         project.project_companies.first
                       else
                         ProjectCompany.order(created_at: :asc).last
                       end
  end

  def call
    quote = Quote.create(project_company: @project_company, price: 115_600)
    file = URI.open(quote_url)
    quote.file.attach(io: file, filename: "quote.pdf", content_type: "application/pdf")
    quote.save
  end

  private

  def quote_url
    "https://res.cloudinary.com/dtxjrhsbk/image/upload/v1686230104/pdf/test_v99pyl.pdf"
  end
end

# CreateQuoteForLastProjectCompany.new(project: Project.find(46)).call
# CreateQuoteForLastProjectCompany.new.call
