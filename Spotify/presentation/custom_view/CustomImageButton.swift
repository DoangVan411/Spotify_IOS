import UIKit

class CustomButton: UIView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let strokeColor = UIColor.white
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        
        setupView(title: title, image: image)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(title: String, image: UIImage?) {
        imageView.image = image ?? UIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        backgroundColor = .clear
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = strokeColor.cgColor
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradient = layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = bounds
        }
    }
    
    @objc private func buttonTapped() {
        print("Button tapped: \(titleLabel.text ?? "")")
    }
}
