def in_dir(dir)
  current = Dir.pwd
  begin
    Dir.chdir(dir)
    yield
  ensure
    Dir.chdir(current)
  end
end

desc 'Deploy the website'
task 'site:deploy' do
  site_dir = File.expand_path( File.dirname(__FILE__) + '/../target/doc')

  file(site_dir).invoke

  origin_url = `git remote get-url origin`

  travis_build_number = ENV['TRAVIS_BUILD_NUMBER']
  if travis_build_number
    origin_url = origin_url.gsub('https://github.com/', 'git@github.com:')
  end

  in_dir(site_dir) do
    sh 'git init'
    sh 'git add .'
    message =
      travis_build_number.nil? ?
        'Publish website' :
        "Publish website - Travis build: #{travis_build_number}"

    sh "git commit -m \"#{message}\""
    sh "git remote add origin #{origin_url}"
    sh 'git push -f origin master:gh-pages'
  end
end
