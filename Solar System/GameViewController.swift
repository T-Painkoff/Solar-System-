//
//  GameViewController.swift
//  Solar System
//
//  Created by Travis  on 9/4/15.
//  Copyright (c) 2015 Travis . All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit


class GameViewController: UIViewController {

    var mercuryNode = SCNNode()
    var venusNode = SCNNode()
    var earthNode = SCNNode()
    var marsNode = SCNNode()
    var jupiterNode = SCNNode()
    var saturnNode = SCNNode()
    var uranusNode = SCNNode()
    var neptuneNode = SCNNode()
    var button: SCNNode!

    var arraySize = 50
    var angleMultiplier = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()

        let angleIncSlider = UISlider(frame: CGRectMake(50, self.view.frame.height - 350, 300, 150))
        angleIncSlider.minimumValue = 0
        angleIncSlider.maximumValue = 100
        angleIncSlider.continuous = true
        angleIncSlider.tintColor = UIColor.redColor()
        angleIncSlider.value = 50
        angleIncSlider.addTarget(self, action: "sliderChanged:", forControlEvents: .ValueChanged)
//        self.view.addSubview(angleIncSlider)


        // create a new scene
        let scene = SCNScene()
        
        // create and add a camera to the scene
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.camera?.zFar = 100000
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 9
        camera.zNear = 0
        camera.zFar = 100
        let cameraNode = SCNNode()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 50)
        cameraNode.camera = camera
        let cameraOrbit = SCNNode()
        cameraOrbit.addChildNode(cameraNode)
        scene.rootNode.addChildNode(cameraOrbit)

        var lastWidthRatio: Float = 0
        var lastHeightRatio: Float = 0

        // rotate it (I've left out some animation code here to show just the rotation)
        func handlePanGesture(sender: UIPanGestureRecognizer) {
            let translation = sender.translationInView(sender.view!)
            let widthRatio = Float(translation.x) / Float(sender.view!.frame.size.width) + lastWidthRatio
            let heightRatio = Float(translation.y) / Float(sender.view!.frame.size.height) + lastHeightRatio
            cameraOrbit.eulerAngles.y = Float(-2 * M_PI) * widthRatio
            cameraOrbit.eulerAngles.x = Float(-M_PI) * heightRatio
            if (sender.state == .Ended) {
                lastWidthRatio = widthRatio % 1
                lastHeightRatio = heightRatio % 1
            }
        }

        func sliderChanged(sender: UISlider!) {
            angleMultiplier = Double(sender.value)

        }



       // scene.rootNode.addChildNode(cameraNode)


        // place the camera
      //  cameraNode.position = SCNVector3(x: 0, y: 0, z: 70)

        
//       //  create and add a light to the scene
//        let light = SCNLight()
//        light.type = SCNLightTypeOmni
//        let lightNode = SCNNode()
//        lightNode.light = light
//        lightNode.light!.color = UIColor.orangeColor()
//        lightNode.position = SCNVector3(x: 360.0, y: 360.0, z: 360.0)
//        scene.rootNode.addChildNode(lightNode)

                // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.clearColor()
        scene.rootNode.addChildNode(ambientLightNode)




        // retrieve the SCNView
        let scnView = self.view as! SCNView!
        
        // set the scene to the view
        scnView.scene = scene

        let tapRegonizer = UITapGestureRecognizer()
        tapRegonizer.numberOfTapsRequired = 1
        tapRegonizer.numberOfTouchesRequired = 1
        tapRegonizer.addTarget(self, action: "sceneTapped:")
        scnView.gestureRecognizers = [tapRegonizer]



        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()



        //PLANETS
        var planets = ["mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"]
        var rings = [4, 5, 6.2, 7.5, 11.8, 13, 14.7, 15.9]  //planet orbit distance

        var size = [ 0.2, 0.4, 0.5, 0.3, 0.9, 0.7, 0.8, 0.6, 0.8 ] //planet physical size

        var orbits = [ 0.5, 0.3, 0.2, 0.189, 0.08, 0.1, 0.07, 0.09, 0.0 ] //planet orbital velocity

        var rotations = [ 1.6, 0.9, 0.906, 0.8, 0.769, 0.2, 0.4, 0.8, 0.2 ] //planet rotation speed


        //COMETS
        var cometSizes = [0000.2, 0000.09, 0000.06, 0000.279, 0000.178] //size of comet
        var cometRing = [15.7,18.365,24.65,27.987,32.54]//orbit size of comet
        var rotationSpeed = [0.07, 0.05, 0.03, 0.02, 0.01]


        var roto = [0.1] //sun roto speed

        var angle:Float = 10.0       //object position float angles
       // let radius:Float = 0.0      //object position float angles
        var y:Float = 2.0           //object position float angles

//
        var cometArray : [SCNSphere] = []

        for i  in 0...self.arraySize {

           // let x = angle + 10.0 * cos(angle)
          //  var cometArrayOrbit = CGFloat()
            let objGeo = SCNSphere(radius: 1.0)
            let objOrbit = SCNTorus(ringRadius: 50.0, pipeRadius: 0.01)
            let objNode = SCNNode(geometry: objOrbit)
            scene.rootNode.addChildNode(objNode)
            objOrbit.firstMaterial?.diffuse.contents = UIColor.clearColor()


            let cmtNode = SCNNode(geometry: objGeo)

            objGeo.firstMaterial?.diffuse.contents = UIImage(named: "texture_moon.jpg")
            objNode.addChildNode(cmtNode)

            cmtNode.position = SCNVector3(x: 17, y: 0, z: 0)
            objNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+30.0), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))




            cometArray.append(objGeo)

            if (cometArray.count < 25) {
//                cometArrayOrbit = 2 * 9
           // let angleIncrement:Float = Float(M_E) * 1.3 / 5


                let node = SCNNode(geometry: objGeo)
                //
                                let x = angle + 5.0 * cos(angle)
                                let z = angle - 0.0 * sin(angle)
                //                //
                node.position = SCNVector3(x: x, y: y, z: z)
                //                //
                cmtNode.addChildNode(node)
                //                //
                //
                var angleIncrement: Float = Float(M_E) * 1.3 / Float(cometArray.count)

                switch i {
                    case 0...10: angleIncrement = (angleIncrement + (Float(i) + 1.0)); break
                    case 11...20: angleIncrement = (angleIncrement + (Float(i) + 1.2)); break
                    case 21...30: angleIncrement = (angleIncrement + (Float(i) + 1.3)); break
                    case 31...40: angleIncrement = (angleIncrement + (Float(i) + 1.4)); break
                    case 41...50: angleIncrement = (angleIncrement + (Float(i) + 1.5)); break
                    default: break

                }
//
                objNode.runAction(SCNAction .repeatActionForever(SCNAction.rotateByX(0, y: CGFloat(angleIncrement), z: CGFloat(angle), duration: 15)))

                //
                                angle += angleIncrement
                                y += 0.2 / 2.0




                // animate a rotation
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(500)
                node.position = SCNVector3Make(Float(angle), angleIncrement, angleIncrement)
                //
                //
                //            SCNTransaction.setCompletionBlock {
                //
                //                // after animating, remove the cubelets from the rotation node,
                //                // and re-add them to the parent node with their transforms altered
                //                node.enumerateChildNodesUsingBlock { cometArray, _ in
                //                    cometArray.transform = cometArray.worldTransform
                //                    cometArray.removeFromParentNode()
                //                    scene.rootNode.addChildNode(node)
                //                }
                //                node.removeFromParentNode()
                //            }
                            SCNTransaction.commit()



            }


        }

            // grab the set of cubelets whose position is along the right face of the puzzle,
            // and add them to the rotation node
//            if cometArray.count < 25 {
//
//                let node = SCNNode(geometry: objGeo)
//
//                let x = angle + 10.0 //* cos(angle)
//                let z = angle - 0.0 //* sin(angle)
//                //
//                node.position = SCNVector3(x: x, y: y, z: z)
//                //
//                cmtNode.addChildNode(node)
//                //
//
//                let angleIncrement:Float = Float(M_E) * 1.3 / Float(cometArray.count)
//
//                angle += angleIncrement
//                y += -1.0 / 2.0




            // animate a rotation
//            SCNTransaction.begin()
//            SCNTransaction.setAnimationDuration(500)
//                //node.position = SCNVector3Make(Float(angle), angle, angleIncrement)
//
//
//            SCNTransaction.setCompletionBlock {
//
//                // after animating, remove the cubelets from the rotation node,
//                // and re-add them to the parent node with their transforms altered
//                node.enumerateChildNodesUsingBlock { cometArray, _ in
//                    cometArray.transform = cometArray.worldTransform
//                    cometArray.removeFromParentNode()
//                    scene.rootNode.addChildNode(node)
//                }
//                node.removeFromParentNode()
//            }
//            SCNTransaction.commit()



       // }
       // }

//test



          //  let hue:CGFloat = CGFloat(index) / CGFloat(geometries.count)
          //  let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)

           // geometry.firstMaterial?.diffuse.contents = color


//test^^^^^



        for index in 0..<cometSizes.count {

            let size = cometSizes[index]
            let cmtRing = CGFloat(cometRing[index])
            let cmtRoto = CGFloat(rotationSpeed[index])

            let cmtOrbits = SCNTorus(ringRadius: cmtRing, pipeRadius: 0.02)
            let bringNode = SCNNode(geometry: cmtOrbits)
            scene.rootNode.addChildNode(bringNode)


//            bringNode.position = SCNVector3Make(Float(angle), angle, angleIncrement)


            cmtOrbits.firstMaterial!.diffuse.contents = UIColor.clearColor()

            let cometGeo = SCNSphere(radius: CGFloat(size))
            let cometNode = SCNNode(geometry:cometGeo)
            bringNode.addChildNode(cometNode)
            cometGeo.firstMaterial?.diffuse.contents = UIImage(named: "texture_moon.jpg")


            cometNode.position = SCNVector3(x: Float(cmtRing), y: 0, z: 0)


            bringNode.runAction(SCNAction .repeatActionForever(SCNAction.rotateByX(0, y: 0, z: cmtRoto, duration: 1)))

             bringNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+75.0), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))


        }
//
//
//
//            let node = SCNNode(geometry: cometGeo)
//
//            let x = radius * cos(angle)
//            let z = radius * sin(angle)
//
//            node.position = SCNVector3(x: x, y: y, z: z)
//
//            bringNode.addChildNode(node)
//
//            angle += angleIncrement
//            y += 2.0
//
//


//            let geometry = cmtOrbits[index]




//            let moveTo = SCNAction.moveByX(-10.0, y: -4.0, z: -8.0, duration: 7.0)
//            let sequence = SCNAction.sequence([moveFrom,moveTo])
//            cometNode.runAction(sequence)

//            cometNode.runAction(SCNAction.repeatActionForever(sequence))
//            bringNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: cmtRoto, z: 0, duration: 1)))

       // }
            for index in 0..<roto.count {
            let sunRoto = CGFloat(roto[index])
            let sunGeo = SCNSphere(radius: CGFloat(2.5))
            sunGeo.firstMaterial?.diffuse.contents = UIImage(named: "texture_sun.jpg")
            let sunNode = SCNNode(geometry: sunGeo)
            sunNode.position = SCNVector3Make(0, 0, 0)
            scene.rootNode.addChildNode(sunNode)
            sunNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: sunRoto, z: 0, duration: 1)))



            }












        for index in 0..<rings.count {
            let ring = CGFloat(rings[index])
            let size = size[index]
            let planet = planets[index]
            let orbit = CGFloat(orbits[index])
            let rotation = CGFloat(rotations[index])

            let ringGeo = SCNTorus(ringRadius: ring, pipeRadius: 0.02)
            let ringNode = SCNNode(geometry: ringGeo)
            scene.rootNode.addChildNode(ringNode)
            //ringGeo.firstMaterial!.diffuse.contents = UIColor.whiteColor()



            let planetGeo = SCNSphere(radius: CGFloat(size))
            let planetNode = SCNNode(geometry: planetGeo)
            ringNode.addChildNode(planetNode)
            planetNode.position = SCNVector3(x: Float(ring), y: 0, z: 0)

            planetGeo.firstMaterial?.diffuse.contents = UIImage(named: "texture_" + planet + ".jpg")
            ringGeo.firstMaterial?.diffuse.contents = UIImage(named: "texture_" + planet + ".jpg")

            ringNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: orbit, z: 0, duration: 1)))

            planetNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: rotation, z: 0, duration: 1)))

            //Planet Axis Tilt VV
            mercuryNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(0), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))

            venusNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+177.36), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))

            earthNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+23.45), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))

            marsNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+25.19), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))

            jupiterNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+3.13), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))

            saturnNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+26.73), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))

            uranusNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+97.77), y:
                GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))

            neptuneNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+28.32), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))




//            let constraint = SCNLookAtConstraint(target:earthNode)
//            constraint.gimbalLockEnabled = true
//            lightNode.constraints = [constraint]


            if index == 5 {

                let saturnRingGeo = SCNSphere(radius: 1.0)
                let saturnRingNode = SCNNode(geometry: saturnRingGeo)
                planetNode.addChildNode(saturnRingNode)
                saturnRingNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 0, z: 0, duration: 1)))


                saturnRingGeo.firstMaterial?.diffuse.contents = UIImage(named: "texture_saturnRing.png")

                let saturnRingsActual = SCNNode(geometry: saturnRingGeo)
                saturnRingNode.addChildNode(saturnRingsActual)

                saturnRingNode.scale = SCNVector3(x: +1.3, y: -0.8, z: +0.09)
               // saturnRingsActual.position = SCNVector3(x: 0.7, y: 0, z: 0)


                saturnRingNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-100.0), y:GLKMathDegreesToRadians(-100.0), z:GLKMathDegreesToRadians((+20.0)))
                
            }






            if index == 2 {

                let moonOrbitNode = SCNNode(geometry: SCNTorus(ringRadius: 0.7, pipeRadius: 0.01))
                planetNode.addChildNode(moonOrbitNode)
                moonOrbitNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 3.2, z: 0, duration: 1)))

                let moonGeo = SCNSphere(radius: CGFloat(0.2))
                moonGeo.firstMaterial?.diffuse.contents = UIImage(named: "texture_moon.jpg")

               let moonNode = SCNNode(geometry: moonGeo)
                moonOrbitNode.addChildNode(moonNode)
                moonNode.position = SCNVector3(x: 0.7, y: 0, z: 0)


                moonNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(+5.0), y:GLKMathDegreesToRadians(0.0), z:GLKMathDegreesToRadians((0.0)))

            }

            if index == 0 { mercuryNode = planetNode }
            if index == 1 { venusNode = planetNode }
            if index == 2 { earthNode = planetNode }
            if index == 3 { marsNode = planetNode }
            if index == 4 { jupiterNode = planetNode }
            if index == 5 { saturnNode = planetNode }
            if index == 6 { uranusNode = planetNode }
            if index == 7 { neptuneNode = planetNode }

        }



//        var cameraX = earthNode.position.x + 5
//        var cameraY = earthNode.position.y + 5
//        var cameraZ = earthNode.position.z + 5
//        cameraNode.position = SCNVector3(x: (cameraX), y: (cameraY), z: (cameraZ) )
//
//
//        cameraNode.constraints = [SCNLookAtConstraint(target: earthNode)]



    }


}
