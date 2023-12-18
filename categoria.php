<?php
require_once("../config/conexion.php");
require_once("../models/Categoria.php");

$categoria = new Categoria();

$body = json_decode(file_get_contents("php://input"), true);

if (isset($_GET["op"])) {
    $opcion = $_GET["op"];
    switch ($opcion) {
        case "GetAll":
            $datos = $categoria->get_categoria();
            echo json_encode($datos);
            break;

        case "GetId":
            var_dump($body);
            if (isset($body["id_usuario"])) {
               $id_usuario = $body["id_usuario"];
               $datos = $categoria->get_categoria_x_id($id_usuario);
               echo json_encode($datos);
            } else {
               echo json_encode(["error" => "El campo 'id_usuario' no está definido en la solicitud"]);
            }
            break;

        case "GetNombre":
            var_dump($body);
            if (isset($body["primer_nombre"])) {
                $primer_nombre = $body["primer_nombre"];
                $datos = $categoria->get_categoria_x_nombre($primer_nombre);
                echo json_encode($datos);
            } else {
                echo json_encode(["error" => "El campo 'primer_nombre' no está definido en la solicitud"]);
            }
            break;

        case "GetIdEmpleado":
            var_dump($body);
            if (isset($body["id_empleado"])) {
                $id_empleado = $body["id_empleado"];
                $datos = $categoria->get_categoria_x_IdEmpleado($id_empleado);
                echo json_encode($datos);
            } else {
                echo json_encode(["error" => "El campo 'id_empleado' no está definido en la solicitud"]);
            }
            break;

        case "GetPedreria":
            var_dump($body);
            if (isset($body["nombre"])) {
                $nombre = $body["nombre"];
                $datos = $categoria->get_categoria_x_Pedreria($nombre);
                echo json_encode($datos);
            } else {
                echo json_encode(["error" => "El campo 'nombre' no está definido en la solicitud"]);
            }
            break;

        case "GetEmpleadoSueldo":
            var_dump($body);
            if (isset($body["sueldo_empleado"])) {
                $sueldo_empleado = $body["sueldo_empleado"];
                $datos = $categoria->get_categoria_x_Empleadosueldo($sueldo_empleado);
                echo json_encode($datos);
            } else {
                echo json_encode(["error" => "El campo 'sueldo_empleado' no está definido en la solicitud"]);
            }
            break;

        case "GetColecciones":
            var_dump($body);
            if (isset($body["nombre_coleccion"])) {
                $nombre_coleccion = $body["nombre_coleccion"];
                $datos = $categoria->get_categoria_x_Colecciones($nombre_coleccion);
                echo json_encode($datos);
            } else {
                echo json_encode(["error" => "El campo 'nombre_coleccion' no está definido en la solicitud"]);
            }
            break;

            case "Insertar":
                var_dump($body);
                if (isset($body["id_colecciones"], $body["nombre_coleccion"], $body["año_coleccion"])) {
                    $id_colecciones = $body["id_colecciones"];
                    $nombre_coleccion = $body["nombre_coleccion"];
                    $año_coleccion = $body["año_coleccion"];
                    $datos = $categoria->Insertar_Colecciones($id_colecciones, $nombre_coleccion, $año_coleccion);
                    echo json_encode(["mensaje" => "Correcto"]);
                } else {
                    echo json_encode(["error" => "Los campos 'id_colecciones' o 'nombre_coleccion' o 'año_coleccion' no están definidos en la solicitud"]);
                }
                break;


                case "update":
                    var_dump($body);
                    if (isset($body["id_colecciones"], $body["nombre_coleccion"], $body["año_coleccion"])) {
                        $id_colecciones = $body["id_colecciones"];
                        $nombre_coleccion = $body["nombre_coleccion"];
                        $año_coleccion = $body["año_coleccion"];
                        $datos = $categoria->update_Colecciones($id_colecciones, $nombre_coleccion, $año_coleccion);
                        echo json_encode(["mensaje" => "Correcto"]);
                    } else {
                        echo json_encode(["error" => "Los campos 'id_colecciones' o 'nombre_coleccion' o 'año_coleccion' no están definidos en la solicitud"]);
                    }
                    break;

                    case "delete":
                        var_dump($body);
                        if (isset($body["id_colecciones"])) {
                            $id_colecciones = $body["id_colecciones"];        
                            $datos = $categoria->delete_colecciones($id_colecciones);
                            echo json_encode(["mensaje" => "delete Correcto"]);
                        } else {
                            echo json_encode(["error" => "El campo 'id_colecciones' no está definido en la solicitud"]);
                        }
                        break;
                    

                
            

        default:
            echo json_encode(["error" => "Opción no válida"]);
            break;
    }
}
?>