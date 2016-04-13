require 'pathname'

def ruby_files
  @file_names ||= Dir.glob('**/*.rb')
end

def declared_constants(file_name)
  [
    file_name,

    File
      .readlines(file_name)
      .select { |line| line.start_with?('class') || line.start_with?('module') }
      .map(&:chomp)
      .map { |declaration| declaration.split[1] }
  ]
end

def constants_used_in_file(file_name)
  [
    file_name,

    File
      .readlines(file_name)
      .map { |line| line.match(/.*\W([A-Z]\w+)/) }
      .compact
      .map { |match| match[1] }
  ]
end

def files_impacted(constants_used_in_files, constant)
  constants_used_in_files.select do |_, constants|
    constants.include? constant
  end
end

def spec_path(file_name)
  return file_name if file_name.end_with? '_spec.rb'

  file_name
    .gsub('app', 'spec')
    .gsub('.rb', '_spec.rb')
end

def find_specs_to_run(changed_files)
  constants_in_files = Hash[
    ruby_files.map { |filename| declared_constants(filename) }
  ]

  constants_used_in_files = Hash[
    ruby_files.map { |file_name| constants_used_in_file(file_name) }
  ]

  constants_impacted = changed_files
    .flat_map { |file_name| constants_in_files[file_name] }
    .compact
    .map { |constant| constant.split('::').last }

  return if constants_impacted.empty?

  files_to_check = constants_impacted
    .flat_map { |constant| files_impacted(constants_used_in_files, constant) }
    .flat_map(&:keys)
    .map { |file_name| spec_path(file_name) }
    .uniq
    .select { |file_name| File.exist? file_name }
end
