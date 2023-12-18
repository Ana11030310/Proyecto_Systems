<?php
class Categoria extends Conectar{
    public function get_categoria(){
        $conectar= parent::conexion();
        parent::set_names();
        $sql="SELECT * FROM usuarios";
        $sql=$conectar->prepare($sql);
        $sql->execute();
        return $resultado=$sql->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_categoria_x_id($id_usuario){
        $conectar= parent::conexion();
        parent::set_names();
        $sql="SELECT * FROM usuarios WHERE id_usuario= ?";
        $sql=$conectar->prepare($sql);
        $sql->bindValue(1, $id_usuario);
        $sql->execute();
        return $resultado=$sql->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_categoria_x_nombre($primer_nombre){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM usuarios WHERE primer_nombre= ?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $primer_nombre); 
        $sql->execute();
        return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_categoria_x_Pedreria($nombre){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM pedreria WHERE nombre= ?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $nombre); 
        $sql->execute();
        return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }

    public function get_categoria_x_Colecciones($nombre_coleccion){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM colecciones WHERE nombre_coleccion= ?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $nombre_coleccion); 
        $sql->execute();
        return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }
    public function Insertar_Colecciones($id_colecciones, $nombre_coleccion, $año_coleccion){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "INSERT INTO colecciones (id_colecciones, año_coleccion, nombre_coleccion) VALUES (?, ?, ?)";
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $id_colecciones);
        $stmt->bindValue(2, $año_coleccion);
        $stmt->bindValue(3, $nombre_coleccion);
        $stmt->execute();
        return $stmt->rowCount();
    }

    public function update_colecciones($id_colecciones, $nombre_coleccion, $año_coleccion) {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "UPDATE colecciones SET 
                 nombre_coleccion = ?, 
                 año_coleccion = ?
                 WHERE
                 id_colecciones = ?";
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $nombre_coleccion);
        $stmt->bindValue(2, $año_coleccion);
        $stmt->bindValue(3, $id_colecciones);
        $stmt->execute();
        return $stmt->rowCount();
    }

    public function delete_colecciones($id_colecciones) {
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "DELETE FROM colecciones WHERE id_colecciones = ?";
        $stmt = $conectar->prepare($sql);
        $stmt->bindValue(1, $id_colecciones);
        $stmt->execute();
        return $stmt->rowCount();
    }
    
}
?>