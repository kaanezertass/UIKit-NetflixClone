//
//  HomeViewController.swift
//  AnkaraMeyhaneler
//
//  Created by Kaan Ezerrtaş on 25.10.2023.
//

import UIKit


enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
    
}

class HomeViewController: UIViewController {
    
    let sectionTile: [String] = ["Popüler Filmler","Popüler Diziler","En İyiler", "Editör Favorileri", "En Çok Yorum Alanlar"] //Başlık Dizisi
    
    private let homeFeedTable: UITableView = { //TableView
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeFeedTable)
        view.backgroundColor = .systemBackground //arka plan rengi
        
        
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
       
        configureNavbar() //Navbarı görünüm için çağrılması
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450)) //
        homeFeedTable.tableHeaderView = headerView
    }
    //NavBar Eklemek
    private func configureNavbar() {
        var image = UIImage(named: "logo") //logo isimli image çağırma
        image = image?.withRenderingMode(.alwaysOriginal) //Orjinal resim!
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil) //Sola sabitleme
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil), //NavBarın sağ tarafına resim eklemek
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil) //NavBarın sağ tarafaına resim eklemek
        ]
        navigationController?.navigationBar.tintColor = .white //navigation bara renk tonu ayarlamak
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        
        
        
    }
    
    
}
    
    
    //TableView
    extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return sectionTile.count //Başlık dizisindeki karekter sayısı kadar değeri döndür
        }
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
                return UITableViewCell()
            }
            
            switch indexPath.section {
            case Sections.TrendingMovies.rawValue:
                
                APICaller.shared.getTrendingMovie { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
                
            case Sections.TrendingTv.rawValue:
                APICaller.shared.trendingTvs { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.Popular.rawValue:
                
                APICaller.shared.getPopular { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.Upcoming.rawValue:
                
                APICaller.shared.getUpcomingMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.TopRated.rawValue:
                
                APICaller.shared.getTopRated { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            default:
                return UITableViewCell()
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //Telefon yüksekliği
            return 200
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { //Yükseklik için kullanılacak alan
            return 40
        }
        
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) { //Başlık görüntüsünü değiştirmek için willDisplayHeaderView fonksiyonunu kullanıyoruz.
            guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold) //başlık fontu
            header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y , width: 100, height: header.bounds.height)//Yazılara ye tayin etmek
            header.textLabel?.textColor = .white //yazı rengi belirleme
            header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter() //Yazıları küçültme
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionTile[section] //Tableview içinde başlıkları tutmak için
        }
        
        //Navigasyon Bar Görünüm Sınırlama -- Aşağı indikçe navbarın kaybolması
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let defaultOffSet = view.safeAreaInsets.top
            let offset = scrollView.contentOffset.y + defaultOffSet
            
            navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        }
    }

    

