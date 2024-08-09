import UIKit

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var backgroundImageView: UIImageView!

    var deals: [RestaurantDeal] = []
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dayPicker.delegate = self
        dayPicker.dataSource = self
        
        // Display deals for the current day when the app loads
        let today = currentDay()
        displayDeals(for: today)
    }

    // Determine the current day of the week
    func currentDay() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

    // Display deals based on the selected day
    func displayDeals(for day: String) {
        print("Displaying deals for \(day)")
        dayLabel.text = day
        deals = loadDeals(for: day.lowercased())
        print("Loaded \(deals.count) deals for \(day)")
        tableView.reloadData()
    }

    // Load deals from JSON file based on the day of the week
    func loadDeals(for day: String) -> [RestaurantDeal] {
        guard let path = Bundle.main.path(forResource: "happyHours", ofType: "json") else {
            print("JSON file not found.")
            return []
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let jsonDict = jsonResult as? [String: [[String: String]]] {
                let dayDeals = jsonDict[day] ?? []
                return dayDeals.map { RestaurantDeal(json: $0) }
            }
        } catch {
            print("Error loading JSON data: \(error)")
        }
        return []
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysOfWeek.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daysOfWeek[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        displayDeals(for: daysOfWeek[row])
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DealCell", for: indexPath) as! DealCell
        let deal = deals[indexPath.row]
        cell.configure(with: deal)
        return cell
    }
}
