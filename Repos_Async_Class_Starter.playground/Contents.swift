import SwiftUI
import Foundation

// Simplified decodable structs from earlier exercise
struct Repositories: Decodable {
  let repos: [Repository]

  enum CodingKeys : String, CodingKey {
    case repos = "items"
  }
}

struct Repository: Decodable {
  let name: String
  let htmlURL: String

  enum CodingKeys : String, CodingKey {
    case name
    case htmlURL = "html_url"
  }
}

// Our initial function (needs fixing...)
func fetchRepositories() async throws -> [Repository] {
  let url = URL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc")!
  let (data, _) = try await URLSession.shared.data(from: url)
  return try JSONDecoder().decode(Repositories.self, from: data).repos
}


// A task to utilize this function
// - call function then loop over repos array to print out the name & url for each
// - interject lots of print statements with 'Step X' to see how things are progressing
Task {
  print("Step 1: Initialize Task")
  // ...
  do {
    print ("Step 2: Get Repos")
    let repositories = try await fetchRepositories()
    print ("Step 3: Get the name and url of the repo")
    for repo in repositories{
      print("- \(repo.name): \(repo.htmlURL)")
    }
    print("Step 4: Catch statement")
  } catch {
    print("Error!!!!")
  }
  print("Step 5: End of task")
}
print("Step 6")
