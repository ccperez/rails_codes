atom_feed do |feed|
  feed.title(@page_title)
  feed.updated(@jobs.first.created_at)

  @jobs.each do |job|
	 feed.entry(job) do |entry|
		entry.title(job.title)
		entry.content(job.description, :type => 'html')
		entry.author {|author| author.name("Conrad Perez")}
	 end
  end
end

