package mrs.domain.model;

import java.io.Serializable;
import javax.persistence.*;

@Entity
public class MeetingRoom implements Serializable {
    private static final long serialVersionUID = 686774175556365789L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer roomId;
    private String roomName;

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }
}