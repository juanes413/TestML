//
//  DetailViewController.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 16/11/21.
//

import UIKit
import SDWebImage
import ImageSlideshow
import SkeletonView

class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOriginalPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelCondition: UILabel!
    @IBOutlet weak var labelWarranty: UILabel!
    
    @IBAction func openAtrributes(_ sender: UIButton) {
        openAttributes()
    }
    
    var productResult: Result?
    var product: Product?
    var viewDidAppear = false
    
    lazy var viewModel = {
        SearchViewModel(viewModelToViewBinding: self)
    }()
    
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
        self.updateBasicUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !viewDidAppear {
            view.showAnimatedGradientSkeleton()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppear = true
    }
    
    //cargar campos basicos de UI
    private func updateBasicUI() {
        if let productResult = productResult {
            labelTitle.text = productResult.title
            updateUIPrice(price: productResult.price)
            
            //Llamar servicios para obtener informacion detallada
            viewModel.detailProductFromService(idProduct: productResult.id)
            viewModel.descripcionProductFromService(idProduct: productResult.id)
        }
    }
    
    //Abrir vista de atributos
    func openAttributes() {
        guard let attributes = product?.attributes, !attributes.isEmpty else {
            return
        }
        let attributesVC = AttributesUITableViewController()
        attributesVC.attributes = attributes
        self.navigationController?.pushViewController(attributesVC, animated: true)
    }
    
}
// MARK: - ModelToViewBinding
extension DetailViewController: ServicesViewModelToViewBinding {
    
    //Servicio que me devuelve informacion del producto
    func serviceDetailProduct(product: Product) {
        self.product = product
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    //Si hay un error al consumir el servicio se muestra un mensaje en pantalla y un boton para reitentar la busqueda nuevamente
    func serviceError() {
        print("error detail")
    }
    
    //Servicio que me trae la descripcion
    func serviceDescriptionProduct(description: Descripcion) {
        if let desc = description.plainText {
            DispatchQueue.main.async {
                self.updateUIDescription(descriptionText: desc)
            }
        }
    }
}
extension DetailViewController {
    
    //Actualizar UI
    private func updateUI() {
        if let product = product {
            
            view.hideSkeleton()
            
            self.configureImageSlideUI(pictures: product.pictures)
            
            if let priceOriginal = product.originalPrice, priceOriginal != product.price, let str = currencyFormatter.string(from: NSNumber(value: priceOriginal)) {
                let attributedString = NSMutableAttributedString(string: "$ \(str)")
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
                
                labelOriginalPrice.attributedText = attributedString
                labelOriginalPrice.isHidden = false
            }
            
            labelCondition.isHidden = product.condition != "new"
            labelWarranty.text = product.warranty
        }
    }
    
    //Actualizar descripcion
    private func updateUIDescription(descriptionText: String) {
        labelDescription.text = descriptionText
    }
    
    //Actualizar precioAnterior
    private func updateUIPrice(price: Int) {
        if let str = currencyFormatter.string(from: NSNumber(value: price)) {
            labelPrice.text = "$ \(str)"
        }
    }
    
    //Configurar el imageSlide
    private func configureImageSlideUI(pictures: [Picture]) {
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        imageSlideshow.pageIndicator = pageControl
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        
        imageSlideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSlideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        var images: [SDWebImageSource] = []
        
        pictures.forEach({ urlImage in
            if let imageSource = SDWebImageSource(urlString: urlImage.secureURL, placeholder: UIImage()) {
                images.append(imageSource)
            }
        })
        
        imageSlideshow.setImageInputs(images)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlideshow.addGestureRecognizer(recognizer)
    }
    
    @objc func didTap() {
        let fullScreenController = imageSlideshow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
}
