
use <utils/build_plate.scad>


//set your build plate
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//if set to "manual" set the  build plate x dimension
build_plate_manual_x = 100; //[100:400]

//if set to "manual" set the  build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);









//Control number of cylinders.
cyl_number=3; //[1,2,3,4,5]


//The scale of the model. 
universal_scale = 2;	


//The resolution of all cylinders, including holes. 
res = 30; //[10:200]












module shell(){


x = 18; //corrective degrees

	difference(){
		union(){



			difference(){ //fin

				difference(){

					cylinder(20, 20, 20, center = true, $fn =5 );

						for ( i = [0 : 4] ){			
    						rotate( i * 360 / 5, [0, 0, 1])
    							translate([20,0,0])
    								cylinder(22,2,2, center=true, $fn = res);
								}
						}

					cylinder(40,6,6, center=true, $fn = res);
			}






difference(){ //fin

	difference(){

		difference(){

			translate([0,0,7]){
				sphere(16,center = true, $fn =res );
			}



		translate([0,0,23]){
			cube([30,30,10],center = true, $fn =res );
		}
		}	

	cylinder(40,6,6, center=true, $fn = res);

	}




		rotate( x, [0, 0, 1]){
	for ( i = [0 : 9] ){			
		rotate( i * 360 / 10, [0, 0, 1])
			translate([17,0,15]){
				cube ([10,4,10], center = true);
			}		
	}


}
}


	rotate( x, [0, 0, 1]){
for ( i = [0 : 9] ){			
	
  rotate( i * 360 / 10, [0, 0, 1])
		translate([14,0,12]){
			cube ([4,4,4], center = true);
		}	
}

}





difference(){

rotate( x, [0, 0, 1]){ //denna
for ( i = [0 : 9] ){		
	rotate( i * 360 / 10, [0, 0, 1])
		translate([14,0,14]){
			rotate ( 90, [0, 1, 0])
				cylinder(4,2,2, center=true, $fn = res);

		}
}
}

rotate( x, [0, 0, 1]){ //denna
for ( i = [0 : 9] ){		
	rotate( i * 360 / 10, [0, 0, 1])
		translate([14,0,14]){
			rotate ( 0, [0, 1, 0])
				cylinder(5,.5,.5, center=true, $fn = res);

		}
}
}

}









rotate( x, [0, 0, 1]){
for ( i = [0 : 9] ){		
	rotate( i * 360 / 10, [0, 0, 1])
		translate([15,0,14]){
			rotate ( 90, [0, 1, 0])
				cylinder(4,1,1, center=true, $fn = res);

		}
}
}

}

for ( i = [0 : 4] ){	

			rotate( i * 360 / 5, [0, 0, 1])		
				translate ([-10,0,0]){
					rotate( 90, [0, 0, 1])
						rotate( 90, [1, 0, 0])
							cylinder(20,6,6, center=true, $fn = res);
				}


}
}
}










module power_shaft(){

	difference(){
	difference(){
	
		union(){
	
			translate([0,0,16]){
				cylinder(5,6,6, center=true, $fn = res);
			}



			for ( i = [0 : 7] ){	
				rotate( i * 360 / 8, [0, 0, 1])	
					translate([4,0,20]){
						cylinder(3,.5,.5, center=true, $fn = res);
					}			
			}


			translate([0,0,20]){
				cylinder(4,1,1, center=true, $fn = res);
			}


			translate([0,0,20]){
				cylinder(3,1,1, center=true, $fn = res);
			}


			translate([0,0,22]){
				cylinder(1,6,6, center=true, $fn = res);
			}


		}


		translate([0,0,15]){
			cylinder(20,.5,.5, center=true, $fn = res);
		}

	}


		translate([0,0,22.5]){
			cylinder(1,2,3, center=true, $fn = res);
		}

	}

}














module cyl(){


	translate([-16,0,0]){
		rotate (90, [1, 0, 0])
			rotate (90, [0, 1, 0])
			cylinder(2,7,7, center=true, $fn = res);
	}

	translate([-17,0,0]){
		rotate (90, [1, 0, 0])
			rotate (90, [0, 1, 0])
			cylinder(2,6,6, center=true, $fn = res);
	}



	difference(){
	union(){
	difference(){

		union(){


						for ( i = [0 : 16] ){			
							translate([-17 - i,0,0]){
								rotate (90, [1, 0, 0])
									rotate (90, [0, 1, 0])
										cylinder(.5,6+ln((i)),6+ln((i)), center=true, $fn = res);
							}
						}
						
						translate([-25,0,0]){
							rotate (90, [1, 0, 0])
								rotate (90, [0, 1, 0])
									cylinder(16,5.5,5.5, center=true, $fn = res);
						}


						translate([-35.2,0,0]){
							rotate (90, [1, 0, 0])
								rotate (90, [0, 1, 0])
									cylinder(4,9,9, center=true, $fn = res);
						}						

		}



						translate([-37,-8,0]){
							rotate (30, [0, 0, 1])
								cube([5,10,20],center=true);

						}

						translate([-37,8,0]){
							rotate (-30, [0, 0, 1])
								cube([5,10,20],center=true);

						}

						translate([-37,0,-11]){
								cube([5,20,20],center=true);

						}

							translate([-35,0,7]){
								cube([5,5,5],center=true);

						}



							translate([-36,0,4.5]){
									rotate (90, [1, 0, 0])
										rotate (90, [0, 1, 0])
											cylinder(4,2.5,2.5,center=true,$fn = res);

							}


										translate([-38.5,0,1]){
								cube([5,.5,5],center=true);

						}

							translate([-38.5,1,1]){
								cube([5,.5,5],center=true);

						}

							translate([-38.5,-1,1]){
								cube([5,.5,5],center=true);

						}

							translate([-38.5,-2,1]){
								cube([5,.5,5],center=true);

						}

							translate([-38.5,2,1]){
								cube([5,.5,5],center=true);

						}



						translate([-35.5,3.5,-3]){
									rotate (90, [0, 1, 0])
										rotate (90, [0, 1, 0])
											cylinder(10,.8,.8,center=true,$fn = res);

						}



				translate([-35.5,-3.5,-3]){
									rotate (90, [0, 1, 0])
										rotate (90, [0, 1, 0])
											cylinder(10,.8,.8,center=true,$fn = res);

						}





	}


						translate([-34,0,4]){
							rotate (35, [0, 1, 0])
								cube([1,5.5,5.5],center=true);

						}

	}					

						translate([-35,0,4.5]){
									rotate (45, [0, 1, 0])
										rotate (90, [0, 1, 0])
											cylinder(10,1.5,1.5,center=true,$fn = res);

						}
	}





}





module back_plate(){

	difference(){
	union(){
	
	for ( i = [0 : 4] ){	
		rotate( i * 360 / 5, [0, 0, 1])		

			difference(){
				union(){

					translate([0,0,-14]){
						cylinder(8,16,16,center=true,$fn = res);
					}


					translate([17,0,-14.5]){
						rotate (0, [0, 1, 0])
							cube([3,3,4],center=true);
					}	





					translate([18.5,0,-14.5]){
						cylinder(4, 1.5,1.5, center=true, $fn = res);
					}

				}			

				translate([18.5,0,-15]){
					cylinder(6, 1,1, center=true, $fn = res);
				}
			}


	}








						translate([-11,0,-21]){
									rotate (0, [0, 1, 0])
										rotate (90, [0, 1, 0])
											cylinder(10,3,3,center=true,$fn = res);

						}

						translate([-6,0,-21]){
									rotate (0, [0, 1, 0])
										rotate (90, [0, 1, 0])
											sphere(3,center = true, $fn =res );

						}

						translate([-11,0,-18.5]){
									rotate (0, [0, 1, 0])
										rotate (90, [0, 1, 0])
												cube([5,6,10],center=true);

						}

						translate([-13,0,-21]){
									rotate (0, [0, 1, 0])
										rotate (90, [0, 1, 0])
											cylinder(10,2.5,2.5,center=true,$fn = res);

						}
						
						translate([-16,0,-21]){
									rotate (0, [0, 1, 0])
										rotate (90, [0, 1, 0])
											cylinder(10,2,2,center=true,$fn = res);

						}


						



	}





						for ( i = [0 : 4] ){	
							rotate( i * 360 / 5, [0, 0, 1])		
								rotate (35, [0, 0, 1]){
									translate([14,0,-16]){
										cylinder(6, 1,1, center=true, $fn = res);
									}
								}
						}
	

	
					for ( i = [0 : 4] ){	
							rotate( i * 360 / 5, [0, 0, 1])		
								rotate (35, [0, 0, 1]){
									translate([14,0,-18]){
										cylinder(1, 1.4,1.4, center=true, $fn = res);
									}
								}
						}






}					



							translate([3,7,-18.5]){
										rotate (45, [0, 0, 45])
											rotate (90, [0, 1, 0])
													cube([10,8,10],center=true);
	
							}




						difference(){



union(){



							translate([3,7,-26.5]){
										rotate (0, [0, 0, 45])
											rotate (90, [0, 1, 0])
													cube([6,6,6],center=true);
	
							}

						
								rotate (67, [0, 0, 1]){             //konstiga vinklar
									translate([10.4,1.2,-26.5]){
									rotate (22.5, [0, 0, 1])
									rotate (90, [0, 1, 0])
										cylinder(.5, 3,2.5, center=true, $fn = res);
									}
								}

								rotate (67, [0, 0, 1]){             //konstiga vinklar
									translate([10.4,1.2,-26.5]){
									rotate (22.5, [0, 0, 1])
									rotate (90, [0, 1, 0])
										cylinder(10, .5,.5, center=true, $fn = res);
									}
								}

								rotate (67, [0, 0, 1]){             //konstiga vinklar
									translate([10.4,1.2,-26.5]){
									rotate (22.5, [0, 0, 1])
									rotate (90, [0, 1, 0])
										cylinder(1, .7,.7, center=true, $fn =5);
									}
								}

								translate([0,1.6,0]){
								rotate (67, [0, 0, 1]){             //konstiga vinklar
									translate([10.4,1.2,-26.5]){
									rotate (22.5, [0, 0, 1])
									rotate (90, [0, 1, 0])
										cylinder(.5, .7,.7, center=true, $fn =5);
									}
								}
								}

								translate([0,4,0]){
								rotate (67, [0, 0, 1]){             //konstiga vinklar
									translate([10.4,1.2,-26.5]){
									rotate (22.5, [0, 0, 1])
									rotate (90, [0, 1, 0])
										cylinder(1.5, .7,.7, center=true, $fn =res);
									}
								}
								}



								rotate (65, [0, 0, 1]){
									translate([7.5,0,-28]){
										cylinder(6, 2,2, center=true, $fn = res);
									}
								}
}




								rotate (65, [0, 0, 1]){
									translate([7.5,0,-28]){
										cylinder(11, 1.9,1.9, center=true, $fn = res);
									}
								}





						}



			difference(){
					union(){


							translate([3,-8,-19]){
										rotate (45, [0, 0, 1])
											rotate (90, [0, 1, 0])
													cube([3,6,9],center=true);
	
							}


							translate([0,-11,-19]){
										rotate (45, [0, 0, 1])
											rotate (0, [0, 1, 0])
												cylinder(3,3.2,3.2, center=true, $fn = res);
	
							}


}
							translate([1.5,-7.5,-20]){
										rotate (45, [0, 0, 1])
											rotate (0, [0, 1, 0])
													cylinder(4,1,1, center=true, $fn = res);
	
							}

							translate([1.5,-11.5,-20]){
										rotate (45, [0, 0, 1])
											rotate (0, [0, 1, 0])
													cylinder(4,1,1, center=true, $fn = res);
	
							}


					}







	difference(){
	



					for ( i = [0 : 4] ){	
							rotate( i * 360 / 5, [0, 0, 1])		


							translate([-14,6,-14]){
										rotate (0, [0, 0, 1])
											rotate (0, [0, 1, 0])
													cube([3,3,3],center=true);
	
							}
					}


						for ( i = [0 : 4] ){	
							rotate( i * 360 / 5, [0, 0, 1])		


							translate([-14,6,-14]){
										rotate (0, [0, 0, 1])
											rotate (90, [0, 1, 0])
													cylinder(4,1,1, center=true, $fn = res);
	
							}
					}



	}



}
					




















module hallare(){
	color([1,0,0]){

difference(){
union(){

		difference(){
			translate([3,0,-3]){
				difference(){
					translate([3,20,-32]){
						cube([45,2,36],center=true);
					}

					translate([-8,20,-47]){
						rotate (40, [0, 1, 0])
							cube([57,4,30],center=true);
					}


				}
	
			}




		translate([4,-20,-10]){
			scale(v=[.7,2,.7]){
				translate([3,0,-3]){
					difference(){
						translate([3,20,-32]){
							cube([45,2,36],center=true);
						}

						translate([-8,20,-47]){
							rotate (40, [0, 1, 0])
								cube([57,4,30],center=true);
						}
					}
				}
			}
		}
}





		difference(){
			union(){
				translate([5.72,19,-19]){
						cube([3,3,4],center=true);
				}

				translate([-14.96,15.4,-19]){
						cube([3,9,3],center=true);
				}

				for ( i = [0 : 4] ){	
					rotate( i * 360 / 5, [0, 0, 1])		
						translate([18.5,0,-18.75]){
							cylinder(4.5, 1.5,1.5, center=true, $fn = res);
						}
				}
			}	


				for ( i = [0 : 4] ){	
					rotate( i * 360 / 5, [0, 0, 1])		
						translate([18.5,0,-18.79]){
							cylinder(5, 1,1, center=true, $fn = res);
						}
				}



		}


mirror([0,1,0]){

		difference(){
			translate([3,0,-3]){
				difference(){
					translate([3,20,-32]){
						cube([45,2,36],center=true);
					}

					translate([-8,20,-47]){
						rotate (40, [0, 1, 0])
							cube([57,4,30],center=true);
					}


				}
	
			}




		translate([4,-20,-10]){

			scale(v=[.7,2,.7]){

				translate([3,0,-3]){
					difference(){
						translate([3,20,-32]){
							cube([45,2,36],center=true);
						}

						translate([-8,20,-47]){
							rotate (40, [0, 1, 0])
								cube([57,4,30],center=true);
						}


					}
	
				}
			}

		}




}





		difference(){

			union(){
				translate([5.72,19,-19]){
						cube([3,3,4],center=true);
				}

				translate([-14.96,15.4,-19]){
						cube([3,9,3],center=true);
				}

				for ( i = [0 : 4] ){	
					rotate( i * 360 / 5, [0, 0, 1])		
						translate([18.5,0,-18.75]){
							cylinder(4.5, 1.5,1.5, center=true, $fn = res);
						}
				}
			}	


				for ( i = [0 : 4] ){	
					rotate( i * 360 / 5, [0, 0, 1])		
						translate([18.5,0,-18.79]){
							cylinder(5, 1,1, center=true, $fn = res);
						}
				}



		}

}	




difference(){

				translate([32,0,-35]){
						cube([7.2,45,45],center=true);
				}


				translate([32,20,-55]){
						rotate( 90, [0, 1, 0])	
							cylinder(8, 1.5,1.5, center=true, $fn = res);

				}


				translate([32,-20,-55]){
						rotate( 90, [0, 1, 0])	
							cylinder(8, 1.5,1.5, center=true, $fn = res);

				}

				translate([32,20,-15]){
						rotate( 90, [0, 1, 0])	
							cylinder(8, 1.5,1.5, center=true, $fn = res);

				}


				translate([32,-20,-15]){
						rotate( 90, [0, 1, 0])	
							cylinder(8, 1.5,1.5, center=true, $fn = res);

				}


				translate([32,0,-15]){
						cube([10,20,10],center=true);
				}







}

}

	translate([20,0,-20]){
						cube([10,20,10],center=true);
				}






}



			



}
}//end
 







module cyl_swing(){

	translate([0,-0.75,0]){
		union(){

			translate([0,0,0]){
				rotate( 90, [1, 0, 0])
					cylinder(.5, 1,1, center=true, $fn = res);

			}

			translate([0,-.5,0]){
				rotate( 90, [1, 0, 0])
					cylinder(.5, .5,.5, center=true, $fn = res);

			}


			translate([0,0,-1]){
				cube([2,.5,2],center=true);
			}


		}
	}

	translate([0,0.75,0]){
		mirror([0,1,0]){
			union(){

				translate([0,0,0]){
					rotate( 90, [1, 0, 0])
						cylinder(.5, 1,1, center=true, $fn = res);

				}

				translate([0,-.5,0]){
					rotate( 90, [1, 0, 0])
						cylinder(.5, .5,.5, center=true, $fn = res);

				}


				translate([0,0,-1]){
					cube([2,.5,2],center=true);
				}


			}
		}

	}


	translate([0,0,-1.8]){
		cube([2,2,.5],center=true);
	}


rotate( 15, [0, 1, 0]){
	union(){


		translate([0,0,0]){
			cube([10,1,1.5],center=true);
		}


		translate([5,0,0]){
			cylinder(1.5, 1,1, center=true, $fn = res);
		}
	}
}
}




module cyl_details(){



		translate([-36,-5,2]){
				rotate( 25, [0, 0, 1])
				rotate( 90, [0, 1, 0])
					cylinder(.5, 1,1, center=true, $fn = res);
		}

		translate([-36,-5,2]){
				rotate( 25, [0, 0, 1])
				rotate( 90, [0, 1, 0])
					cylinder(3, .3,.3, center=true, $fn = res);
		}

		translate([-37,-5.5,2]){
				rotate( 25, [0, 0, 1])
				rotate( 90, [0, 1, 0])
					cylinder(.25, 1,1, center=true, $fn = res);
		}

		translate([-37.5,-5.7,5]){
			rotate( 25, [0, 0, 1])
				rotate( -90, [0, 1, 0])
					cyl_swing();
		}

color([0.2,0.2,0.2]){
		translate([-35.7,-4.9,9.7]){
			sphere(.85,$fn = res) ;
		}


			translate([-15.9,-5.15,14]){
			sphere(.85,$fn = res) ;
		}

		translate([-25.7,-5.2,11.9]){
				rotate( 5, [1, 0, 0])
				rotate( -12.5, [0, 1, 0])
				rotate( 90, [0, 1, 0])
					cylinder(20, .25,.25, center=true, $fn = res);
		}

}

mirror([0,1,0]){

	translate([-36,-5,2]){
				rotate( 25, [0, 0, 1])
				rotate( 90, [0, 1, 0])
					cylinder(.5, 1,1, center=true, $fn = res);
		}

		translate([-36,-5,2]){
				rotate( 25, [0, 0, 1])
				rotate( 90, [0, 1, 0])
					cylinder(3, .3,.3, center=true, $fn = res);
		}

		translate([-37,-5.5,2]){
				rotate( 25, [0, 0, 1])
				rotate( 90, [0, 1, 0])
					cylinder(.25, 1,1, center=true, $fn = res);
		}

		translate([-37.5,-5.7,5]){
			rotate( 25, [0, 0, 1])
				rotate( -90, [0, 1, 0])
					cyl_swing();
		}


color([0.2,0.2,0.2]){

		translate([-35.7,-4.9,9.7]){
			sphere(.85,$fn = res) ;
		}


			translate([-15.9,-5.15,14]){
			sphere(.85,$fn = res) ;
		}

		translate([-25.7,-5.2,11.9]){
				rotate( 5, [1, 0, 0])
				rotate( -12.5, [0, 1, 0])
				rotate( 90, [0, 1, 0])
					cylinder(20, .25,.25, center=true, $fn = res);
		}

}


}


		translate([-35,0,4.35]){
				rotate( 35, [0, 1, 0])
				rotate( 90, [0, 1, 0])
					cylinder(3, 1.5,1.5, center=true, $fn = res);
		}



		translate([-35.5,0,4.6]){
				rotate( 35, [0, 1, 0])
				rotate( 90, [0, 1, 0])
					cylinder(1, 2,2, center=true, $fn = 6);
		}


		translate([-37,0,5.8]){
				rotate( 35, [0, 1, 0])
				rotate( 90, [0, 1, 0])
					cylinder(3, .7,1, center=true, $fn = res);
		}







}


module skruvar(){
color([0.8,0.8,0.8]){
difference(){
union(){

	difference(){
		
		for ( i = [0 : 4] ){	
			rotate( i * 360 / 5, [0, 0, 1])		
				rotate (35, [0, 0, 1]){
					translate([14,0,-16]){
						cylinder(2,1,1, center=true, $fn = res);
					}
				}
		}


		for ( i = [0 : 4] ){	
			rotate( i * 360 / 5, [0, 0, 1])		
				rotate (35, [0, 0, 1]){
					translate([14,0,-17]){
						cylinder(2,.7,.7, center=true, $fn = 6);
					}
				}
		}



	}



difference(){

	union(){

			for ( i = [0 : 4] ){	
					rotate( i * 360 / 5, [0, 0, 1])		
						translate([18.5,0,-17]){
							cylinder(12, 1,1, center=true, $fn = res);
						}
				}




				for ( i = [0 : 4] ){	
					rotate( i * 360 / 5, [0, 0, 1])		
						translate([18.5,0,-22.5]){
							cylinder(3, 1.6,1.6, center=true, $fn = res);
						}
				}

	}




				for ( i = [0 : 4] ){	
					rotate( i * 360 / 5, [0, 0, 1])		
						translate([18.5,0,-23]){
							cylinder(3, 1.2,1.2, center=true, $fn = 6);
						}
				}

	}
}

				translate([20,0,-20]){
						cube([10,20,10],center=true);
				}

}

}
}


module sladd_sak(){
	color([0.3,0.3,0.3]){

	translate([-23,0,-21]){
									rotate (0, [0, 1, 0])
										rotate (90, [0, 1, 0])
											cylinder(5,5,5,center=true,$fn = res);

						}



							for ( i = [0 : 4] ){	
									

									translate([-26,0,-21]){
										rotate (90, [0, 1, 0])
											rotate( i * 360 / 5, [0, 0, 1])		
													translate([0,3,0]){
														cylinder(5,.8,1,center=true,$fn = res);
													}
									}
							}
}


}



//renderererer

scale([universal_scale,universal_scale,universal_scale]){
	rotate( 90, [0, 1, 0])	
		translate([-35.58,0,13]){

					color([0,0.6,0.8]){
						shell();
							back_plate();
					}

	

	
					for ( i = [0 : cyl_number-1] ){	
							rotate( i * 360 / 5, [0, 0, 1])	
								union(){	

									color([0.8,0.8,0.8]){
										cyl();
									}		
			
										cyl_details();
									}
					}

	
					color([0.4,0.4,0.4]){
						hallare();
							power_shaft();
					}	

	skruvar();
	sladd_sak();
}
}
