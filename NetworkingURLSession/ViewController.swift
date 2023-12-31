//
//  ViewController.swift
//  NetworkingURLSession
//
//  Created by Minaya Yagubova on 23.03.23.
//

import UIKit

struct Post: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    //NETWORKING
    //Core lib: URLSession
    //3rd party: Alamofire (AFNetWorking), Moya
        
    //METHODS: GET, POST, PUT (PATCH), DELETE
    //BASEURL: STATIC URL
    
    var items = [Post]()
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getPostItems()
        getPostItemsWithRequest()
    }
    
    func getPostItems() {
        
//        let task =
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    self.items = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
//        task.resume()
    }
    
    func getPostItemsWithRequest() {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["userToken": "12310923asdasjlkdajlk1k1209u",
                                       "lang": "aze"]
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    self.items = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
}
