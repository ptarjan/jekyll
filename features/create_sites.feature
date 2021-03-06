Feature: Create sites
  As a hacker who likes to blog
  I want to be able to make a static site
  In order to share my awesome ideas with the interwebs

  Scenario: Basic site
    Given I have an "index.html" file that contains "Basic Site"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Basic Site" in "_site/index.html"

  Scenario: Basic site with a post
    Given I have a _posts directory
    And I have the following post:
      | title   | date      | content          |
      | Hackers | 3/27/2009 | My First Exploit |
    When I run jekyll
    Then the _site directory should exist
    And I should see "My First Exploit" in "_site/2009/03/27/hackers.html"

  Scenario: Basic site with layout and a page
    Given I have a _layouts directory
    And I have an "index.html" page with layout "default" that contains "Basic Site with Layout"
    And I have a default layout that contains "Page Layout: {{ content }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Page Layout: Basic Site with Layout" in "_site/index.html"

  Scenario: Basic site with layout and a post
    Given I have a _layouts directory
    And I have a _posts directory
    And I have the following posts:
      | title    | date      | layout  | content                               |
      | Wargames | 3/27/2009 | default | The only winning move is not to play. |
    And I have a default layout that contains "Post Layout: {{ content }}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Post Layout: <p>The only winning move is not to play.</p>" in "_site/2009/03/27/wargames.html"

  Scenario: Basic site with layouts, pages, posts and files
    Given I have a _layouts directory
    And I have a page layout that contains "Page Layout: {{ site.posts.size }}"
    And I have a post layout that contains "Post Layout: {{ content }}"
    And I have an "index.html" page with layout "page" that contains "site index page"
    And I have a blog directory
    And I have a "blog/index.html" page with layout "page" that contains "category index page"
    And I have an "about.html" file that contains "No replacement {{ site.posts.size }}"
    And I have an "another_file" file that contains ""
    And I have a _posts directory
    And I have the following posts:
      | title     | date      | layout  | content                                |
      | entry1    | 3/27/2009 | post    | content for entry1.                    |
      | entry2    | 4/27/2009 | post    | content for entry2.                    |
    And I have a category/_posts directory
    And I have the following posts in "category":
      | title     | date      | layout  | content                                |
      | entry3    | 5/27/2009 | post    | content for entry3.                    |
      | entry4    | 6/27/2009 | post    | content for entry4.                    |
    When I run jekyll
    Then the _site directory should exist
    And I should see "Page Layout: 4" in "_site/index.html"
    And I should see "No replacement \{\{ site.posts.size \}\}" in "_site/about.html"
    And I should see "" in "_site/another_file"
    And I should see "Page Layout: 4" in "_site/blog/index.html"
    And I should see "Post Layout: <p>content for entry1.</p>" in "_site/2009/03/27/entry1.html"
    And I should see "Post Layout: <p>content for entry2.</p>" in "_site/2009/04/27/entry2.html"
    And I should see "Post Layout: <p>content for entry3.</p>" in "_site/category/2009/05/27/entry3.html"
    And I should see "Post Layout: <p>content for entry4.</p>" in "_site/category/2009/06/27/entry4.html"

  Scenario: Basic site with include tag
    Given I have a _includes directory
    And I have an "index.html" page that contains "Basic Site with include tag: {% include about.textile %}"
    And I have an "_includes/about.textile" file that contains "Generated by Jekyll"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Basic Site with include tag: Generated by Jekyll" in "_site/index.html"

  Scenario: Basic site with subdir include tag
    Given I have a _includes directory
    And I have an "_includes/about.textile" file that contains "Generated by Jekyll"
    And I have an info directory
    And I have an "info/index.html" page that contains "Basic Site with subdir include tag: {% include about.textile %}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Basic Site with subdir include tag: Generated by Jekyll" in "_site/info/index.html"

  Scenario: Basic site with nested include tag
    Given I have a _includes directory
    And I have an "_includes/about.textile" file that contains "Generated by {% include jekyll.textile %}"
    And I have an "_includes/jekyll.textile" file that contains "Jekyll"
    And I have an "index.html" page that contains "Basic Site with include tag: {% include about.textile %}"
    When I run jekyll
    Then the _site directory should exist
    And I should see "Basic Site with include tag: Generated by Jekyll" in "_site/index.html"