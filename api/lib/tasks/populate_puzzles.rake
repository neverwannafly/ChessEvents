require "csv"

task :populate_puzzles => :environment do

  PUZZLES_UPSTREAM_PATH = 'https://chessevents-buckets.s3.ap-south-1.amazonaws.com/puzzles.csv'
  THEMES_UPSTREAM_PATH = 'https://chessevents-buckets.s3.ap-south-1.amazonaws.com/themes.xml'

  PUZZLES_LOCAL_PATH = File.join(Rails.root, 'puzzles.csv')
  THEMES_LOCAL_PATH = File.join(Rails.root, 'themes.xml')

  # IO.copy_stream(URI.open(PUZZLES_UPSTREAM_PATH), PUZZLES_LOCAL_PATH)
  # IO.copy_stream(URI.open(THEMES_UPSTREAM_PATH), THEMES_LOCAL_PATH)

  def theme_hash(xml, idx)
    {
      slug: xml[idx].values[0],
      title: xml[idx].text,
      description: xml[idx + 2].text,
    }
  end

  def puzzle_hash(row)
    {
      slug: row[0] + SecureRandom.alphanumeric(3),
      starting_position_fen: row[1],
      solution: row[2],
      rating: row[3],
      rating_deviation: row[4],
      initial_popularity: row[5],
      themes: row[7].split(' '),
    }
  end

  file = File.read(THEMES_LOCAL_PATH)
  xml = Nokogiri::XML(file)
  nodes = xml.children[0].children
  idx = 1

  while idx + 2 < nodes.count
    theme = theme_hash(nodes, idx)
    # Theme.create(theme)
    idx += 4
  end

  id = 0
  File.open(PUZZLES_LOCAL_PATH) do |file|
    file.lazy.each_slice(10000) do |lines|
      puzzles = []
      theme_associations = []
      themes = Theme.all.to_a

      lines.each do |line|
        data = puzzle_hash(line.split(','))
        puzzle_data = data.except(:themes)
        id += 1

        puzzles << Puzzle.new(puzzle_data)
        data[:themes].each do |theme|
          tid = themes.find { |s| s.slug == theme }&.id
          next if tid.blank?

          theme_associations << ThemeAssociation.new({
            theme_id: tid,
            associate_type: 'Puzzle',
            associate_id: id,
          })
        end
      end

      puts "finished #{id}"

      ThemeAssociation.import! theme_associations
      Puzzle.import! puzzles 
    end
  end
end