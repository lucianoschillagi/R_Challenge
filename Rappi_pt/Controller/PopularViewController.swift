//
//  PopularViewController.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 19/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
Una pantalla que contiene una tabla con películas populares curadas por TMDb.
*/

class PopularViewController: UIViewController {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	//
	var popularMovies: [TMDbMovie] = [TMDbMovie]()
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var tableView: UITableView!
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
			
			debugPrint("↗️\(popularMovies)")
			
			// networking 🚀
			startRequest()
			
	} // end view did load

	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas populares
	func startRequest() {
		
		// networking ⬇
		TMDbClient.getPopularMovies { (success, popularMovies, error) in
			
			// dispatch
			DispatchQueue.main.async {
				
				// si la solicitud fue exitosa
				if success {
					print("HOLA")
					
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let popularMovies = popularMovies {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.popularMovies = popularMovies // 🔌 👏
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
						debugPrint("↗️\(popularMovies.count)")
						
						
						
					}
					
				} else {
					
				}
				
			}
			
		}
		
	}
	

	//*****************************************************************
	// MARK: - UI Enabled-Disabled
	//*****************************************************************
	
	// task: habilitar o deshabilitar la UI de acuerdo a la lógica de la aplicación
//	func setUIEnabled(_ enabled: Bool) {
//		nextButton.isEnabled = enabled
//		if enabled {
//			nextButton.alpha = 1.0
//		} else {
//			nextButton.alpha = 0.5
//		}
//	}
	
	//*****************************************************************
	// MARK: - Activity Indicator
	//*****************************************************************
	
	func startActivityIndicator() {
		activityIndicator.alpha = 1.0
		activityIndicator.startAnimating()
	}
	
	func stopActivityIndicator() {
		activityIndicator.alpha = 0.0
		self.activityIndicator.stopAnimating()
	}
	

} // end class


//*****************************************************************
// MARK: - Table View Data Source Methods
//*****************************************************************

extension PopularViewController: UITableViewDataSource {
	
	// task: determinar cuantas filas tendrá la tabla
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
	
		return popularMovies.count
	}
	
	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		let movie = popularMovies[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		cell?.textLabel?.text = movie.title
			
			
	
//		cell?.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
//
//
//		if let thumbPath = creditCard.thumb {
//			// realiza la solicitud para obtener la imágen
//			let _ = MercadoPagoClient.taskForGETImage(thumbPath) { (imageData, error) in
//				if let image = UIImage(data:imageData!) {
//
//					DispatchQueue.main.async {
//						cell?.imageView?.image = image
//					}
//				} else {
//					print(error ?? "empty error")
//				}
//			}
//
//		} // end optional binding
		
		return cell!
		
	}
	
} // end class


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

//extension PopularViewController: UITableViewDelegate {
//	
//	// task: almacenar el nombre de la tarjeta seleccionada para su posterior uso en la solicitud web
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		
//		let creditCard = allCreditCards[(indexPath as NSIndexPath).row]
//		MercadoPagoClient.ParameterValues.PaymentMethod = creditCard.id // 🔌 👏
//		PayMethodViewController.creditCardChoosen = creditCard.name // 🔌 👏
//		
//		setUIEnabled(true)
//	}
//	
//} // end ext


//*****************************************************************
// MARK: - Navigation (Segue)
//*****************************************************************

//extension PopularViewController {
//
//	// task: enviar a 'BankViewController' el valor de la tarjeta seleccionada, para imprimirla luego en una etiqueta
//	override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
//
//		// si este vc tiene un segue con el identificador "toBankVC"
//		if segue.identifier == "toBankVC" {
//			let bankVC = segue.destination as! BankViewController
//			bankVC.creditCardSelected = PayMethodViewController.creditCardChoosen
//
//		}
//	}
//}
