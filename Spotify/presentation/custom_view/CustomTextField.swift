import UIKit

class CustomTextField: UIView {

    private var isPassword = false
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    var placeholder: String? {
        didSet { updatePlaceholder() }
    }
    
    var isPasswordField: Bool = false {
        didSet {
            textField.isSecureTextEntry = isPasswordField
            passwordIcon.isHidden = !isPasswordField
            updatePasswordIcon()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.tintColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        textField.leftViewMode = .always
        
        addSubview(textField)
        addSubview(passwordIcon)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: passwordIcon.leadingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            passwordIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            passwordIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            passwordIcon.widthAnchor.constraint(equalToConstant: 20),
            passwordIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        passwordIcon.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }
    
    private func updatePlaceholder() {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
    }
    
    private func updatePasswordIcon() {
        let iconImage = textField.isSecureTextEntry
            ? UIImage(named: "hide")
            : UIImage(named: "home_gray")
        passwordIcon.setImage(iconImage, for: .normal)
    }
    
    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        updatePasswordIcon()
    }
}
