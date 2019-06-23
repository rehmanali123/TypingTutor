package org.tutor.user;

public class Quote {

	private int id;
	private String quote;
	private String reference;
	private String author;
	private String status;

	public Quote() {

	}
	
	public Quote(String quote, String reference, String author, String status) {

		this.quote = quote;
		this.reference = reference;
		this.author = author;
		this.status = status;
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getQuote() {
		return quote;
	}

	public void setQuote(String quote) {
		this.quote = quote;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Quote [quote=" + quote + ", reference=" + reference + ", author=" + author + ", status=" + status + "]";
	}

}
