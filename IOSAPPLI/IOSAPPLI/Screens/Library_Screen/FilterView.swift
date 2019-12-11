//
//  FilterView.swift
//  IOSAPPLI
//
//  Created by Julie Saby on 10/12/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit

protocol FilterProtocol: class {
	func selectFilter(type: FilterType, value: String)
}

enum FilterType : String {
    case year
    case like
	case type
    case status
}

class FilterView: UIView, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var selectButton: UIButton!
//	@IBOutlet weak var tableView: UITableView!
//	@IBOutlet weak var tableViewHeight: NSLayoutConstraint!
	
	 var tableView: UITableView!
	
	var delegate: FilterProtocol?
	var parentView: UIView?
	
	var filterType: FilterType!
	var isSelectExpanded: Bool = false
	var selectValues = [String]()
	var selectedValue: Int?
	
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = "FilterView"
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView.prepareForInterfaceBuilder()
    }

	func configure(_ filterType: FilterType) {
		self.filterType = filterType

		switch filterType {
		case .year:
			iconImageView.image = UIImage(named: "Fichier 27")
			titleLabel.text = "Années"
			selectValues = ["A", "B", "C", "D"]
		case .like:
			iconImageView.image = UIImage(named: "Fichier 19")
			titleLabel.text = "Aimer"
			selectValues = ["E", "F", "G", "H"]
		case .type:
			iconImageView.image = UIImage(named: "Fichier 1")
			titleLabel.text = "Genre"
			selectValues = ["I", "J", "K", "L"]
		case .status:
			iconImageView.image = UIImage(named: "Fichier 21")
			titleLabel.text = "Status"
			selectValues = ["M", "N", "O", "P"]
		}
		
		contentView.clipsToBounds = false
		
		tableView = UITableView(frame: CGRect(x: self.frame.origin.x,
											  y: self.frame.origin.y + self.frame.height - 10,
											  width: self.frame.width,
											  height: CGFloat(selectValues.count * 44)))
		tableView.clipsToBounds = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.isHidden = !isSelectExpanded
		tableView.layer.zPosition = 10000
		parentView?.addSubview(tableView)
	}
	
	@IBAction func showSelectValues(sender: Any) {
		isSelectExpanded = !isSelectExpanded
		tableView.isHidden = !isSelectExpanded
	}
	
	//MARK: - UITableViewDelegate, UITableViewDataSource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return selectValues.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = selectValues[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedValue = indexPath.row
		selectButton.setTitle(selectValues[indexPath.row], for: .normal)
		tableView.isHidden = true
		isSelectExpanded = false
		tableView.deselectRow(at: indexPath, animated: false)
		
		delegate?.selectFilter(type: filterType, value: selectValues[indexPath.row])
	}
}
