package gr.athtech.toDoAppWithLogin.repository;

import gr.athtech.toDoAppWithLogin.model.security.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
}
