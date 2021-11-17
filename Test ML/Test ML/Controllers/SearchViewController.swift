//
//  ViewController.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 14/11/21.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelEmpty: UILabel!
    @IBOutlet weak var viewError: UIStackView!
    
    //Reintentar busqueda
    @IBAction func reloadSearch(_ sender: UIButton) {
        newSearch()
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var results = [Result]()
    
    private var productsViewModel: SearchViewModel?
    
    private lazy var viewModel = {
        SearchViewModel(viewModelToViewBinding: self)
    }()
    
    private enum ReuseIdentifiers: String {
        case searchItemUITableViewCell
    }
    
    private var firstTime = true
    
    // Formato para mostrar el precio de un producto
    let currencyFormatter: NumberFormatter = {
        let formatter =  NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Se inicializan los componentes UI
        configureSearchBar()
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: true, completion: nil)
    }
    
    //Apenas muestre la pantalla se enfoca el buscador
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if firstTime {
            DispatchQueue.main.async {
                self.searchController.searchBar.becomeFirstResponder()
                self.firstTime = false
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let item = results[self.tableView.indexPathForSelectedRow!.row]
            destination.productResult = item
        }
    }
    
}
// MARK: - UISearchBar
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    //Este metodo se llama cuando se da tap al boton buscar del teclado
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        newSearch()
    }
    
    //Metodo para generar una nueva busqueda
    private func newSearch() {
        self.results.removeAll()
        self.reloadData()
        self.setVisibilityEmpty(hidden: true)
        self.setVisibilityNoFoundResults(hidden: true)
        
        //Se verifica que el texto que se desea buscar sea de por lo menos una letra
        if let searchText = searchController.searchBar.text?.trimmingCharacters(in:.whitespacesAndNewlines), searchText.count > 0 {
            searchController.searchBar.resignFirstResponder()
            searchProducts(searchText: searchText)
        } else {
            DispatchQueue.main.async {
                self.searchController.searchBar.becomeFirstResponder()
            }
        }
    }
    
    //Invocacion del services (API)
    private func searchProducts(searchText: String) {
        viewModel.searchFromService(searchText: searchText)
    }
    
}
// MARK: - ModelToViewBinding
extension SearchViewController: ServicesViewModelToViewBinding {
    
    //Este metodo se ejecuta cuando el servicio devuelve el resultado de la busqueda
    func serviceSearchResult(results: SearchData) {
        self.results = results.results
        
        if (self.results.isEmpty) {
            DispatchQueue.main.async {
                self.setVisibilityNoFoundResults(hidden: false)
            }
        }
        
        self.reloadData()
    }
    
    //Si hay un error al consumir el servicio se muestra un mensaje en pantalla y un boton para reitentar la busqueda nuevamente
    func serviceError() {
        self.results.removeAll()
        self.reloadData()
        
        DispatchQueue.main.async {
            self.setVisibilityEmpty(hidden: false)
        }
    }
    
}
// MARK: - UITableView
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.searchItemUITableViewCell.rawValue, for: indexPath) as? SearchItemUITableViewCell else {
            return UITableViewCell()
        }
        
        let item = results[indexPath.row]
        
        cell.imageViewThumbnail.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(), options: [], completed: nil)
        cell.labelTitle.text = item.title
        if let str = currencyFormatter.string(from: NSNumber(value: item.price)) {
            cell.labelPrice.text = "$ \(str)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openDetailProduct", sender: self)
    }
    
}
// MARK: - UI
extension SearchViewController {
    
    //Configuracion UI, se agrega un searchcontroller para el buscador
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.setNewcolor(color: UIColor.black)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationItem.searchController?.searchBar.delegate = self
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.definesPresentationContext = true
    }
    
    //Configuracion de la tableView
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsMultipleSelection = false
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 108
        
        self.tableView.register(UINib(nibName: "SearchItemUITableViewCell", bundle: nil), forCellReuseIdentifier: ReuseIdentifiers.searchItemUITableViewCell.rawValue)
    }
    
    //Refrescar informacion
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //Mostrar u ocultar, vista de cuando hay un error al invocar el servicio
    private func setVisibilityEmpty(hidden: Bool){
        viewError.isHidden = hidden
    }
    
    //Mostrar u ocultar, label sin resultados
    private func setVisibilityNoFoundResults(hidden: Bool){
        labelEmpty.isHidden = hidden
    }
    
}
