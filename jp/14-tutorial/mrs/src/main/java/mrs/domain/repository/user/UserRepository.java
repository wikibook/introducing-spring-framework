package mrs.domain.repository.user;

import org.springframework.data.jpa.repository.JpaRepository;
import mrs.domain.model.User;

public interface UserRepository extends JpaRepository<User, String> {
}