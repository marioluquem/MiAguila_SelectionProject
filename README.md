# MiAguila_SelectionProject
Repositorio para realizar la aplicación para el proceso de selección de la empresa Mi Águila


Flujo de Git utilizado: 
    Git Flow
        Ramas:
            - main (master)
            - mario-develop (para el desarrollo)
            - features (para nuevas funcionalidades que luego harán merge con mario-develop al ser culminadas)
            - release (opcional, para terminar de pulir la rama develop antes de pasarlo a la rama main)


Funcionalidades realizadas:
    - Se creó BloC (Cubit) para gestionar los estos de los productos
    - Se crearon 3 pantallas: HomeScreen, ShoppingCartScreen y DetailScreen
    - Se obtuvieron datos de productos desde fakestoreapi.com haciendo uso del paquete "Dio"
    - Se añadió una funcionalidad de productos "destacados" en la parte superior del Home, con un "carousel" de productos
    - Se añadió una vista minimalista de los productos del carrito en la parte inferior del Home para mayor control
    - Se añadieron las funcionalidades de "agregar al carrito" y "eliminar del carrito"
    - Se creó BloC (Cubit) para gestionar los estados del internet y poder trabajar sin conexión
    - Se creó la funcionalidad de almacenar los estados de la aplicación en el storage del teléfono por medio del paquete Hydrated_Bloc (basado en Hive)
    - Se colocaron imágenes "por defecto" en los productos al trabajar sin conexión
    - Se creó BloC (Cubit) para gestionar los estados de los dynamic links
    - Se creó la funcionalidad de dynamic link con firebase para poder compartir productos por whatsapp o algún otro medio y visualizar el detalle al abrir el link generado
    - Se creó un inyector de dependencias con el paquete Get_It para mayor control de los controllers y repositories
    - Se generó un ícono para la app
