//
//  ViewController.swift
//  CollapseSectionApp
//
//  Created by Grigory Sapogov on 03.11.2023.
//

import UIKit

class ViewController: UIViewController {

    var tableView = UITableView(frame: .zero, style: .plain)
    
    var array: [Paragraph] {
        self.originalArray.filter { !$0.isHidded }
    }
    
    var originalArray: [Paragraph] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.layout()
        self.updateData()
    }
    
    private func updateData() {
        
        self.originalArray = [
            Paragraph(name: "Глава 1", type: 1),
            Paragraph(name: "Глава 2", type: 2),
            Paragraph(name: "Глава 3", type: 3),
            Paragraph(name: "Глава 4", type: 1),
            Paragraph(name: "Глава 5", type: 2),
            Paragraph(name: "Глава 6", type: 3)
        ]
        
    }

    private func setupTableView() {
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func layout() {
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
    }

    private func toggleParagraph(paragraph: Paragraph) {
        
        paragraph.isCollapsed.toggle()
        let childParagraphs = self.childParagraph(forParagraph: paragraph)
        for childParagraph in childParagraphs {
            childParagraph.isHidded.toggle()
        }
        self.tableView.reloadData()
    }
    
    private func childParagraph(forParagraph paragraph: Paragraph) -> [Paragraph] {

        var result: [Paragraph] = []
        
        var startChildAppending = false
        
        for paragraphValue in self.originalArray {
            
            if paragraphValue.name == paragraph.name {
                startChildAppending = true
                continue
            }
            
            if startChildAppending {
            
                if paragraphValue.type > paragraph.type {
                    result.append(paragraphValue)
                }
                else if startChildAppending && paragraphValue.type <= paragraph.type {
                    break
                }
                
            }
            
        }
        
        return result
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let paragraph = self.array[section]
        return paragraph.isCollapsed ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let section = self.array[indexPath.section]
        cell.textLabel?.text = section.cellText
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? SectionHeaderView else { return nil }
        let paragraph = self.array[section]
        headerView.setup(paragraph: paragraph)
        headerView.action = { [weak self] paragraph in
            self?.toggleParagraph(paragraph: paragraph)
        }
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let paragraph = self.array[indexPath.section]
        return paragraph.isCollapsed ? 0 : UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}
